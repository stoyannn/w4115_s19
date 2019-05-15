(*
 * JIJO LLVM IR generator.
 *)

open Llvm
open Jijosast

module L = Llvm
module A = Jijoast
module StringMap = Map.Make(String)


(* LLVM IR generation context *)
type context = {
  parent: context option;
  builder: L.llbuilder;
  vartab: L.llvalue StringMap.t;
}


let llmodule_of_sprogram sprogram =


let g_cont = L.global_context ()
in
let g_mod = L.create_module g_cont "Jijo"
and g_i8 = L.i8_type g_cont
and g_dbl = L.double_type g_cont
in
let g_val = L.struct_type g_cont [| g_i8; g_dbl |]
in
let g_funtab =
  let add_sfunc m f =
    let args = Array.of_list (g_val :: (List.map (fun _ -> g_val) f.sargs))
    in
    let func = L.function_type g_val args
    in
    StringMap.add f.sname (L.define_function f.sname func g_mod, f) m
  in
  List.fold_left add_sfunc StringMap.empty sprogram.sfuncs;
in
let g_void = L.const_int g_i8 0
and g_null = L.const_int g_i8 1
and g_bool = L.const_int g_i8 2
and g_num = L.const_int g_i8 3
and g_str = L.const_int g_i8 4
and g_obj = L.const_int g_i8 5
and g_arr = L.const_int g_i8 6
in
let g_void_z = L.const_struct g_cont [| g_void; L.const_float g_dbl 0.0 |]
and g_null_z = L.const_struct g_cont [| g_null; L.const_float g_dbl 0.0 |]
and g_bool_t = L.const_struct g_cont [| g_bool; L.const_float g_dbl 1.0 |]
and g_bool_f = L.const_struct g_cont [| g_bool; L.const_float g_dbl 0.0 |]
and g_num_z = L.const_struct g_cont [| g_num; L.const_float g_dbl 0.0 |]
and g_str_z = L.const_struct g_cont [| g_str; L.const_float g_dbl 0.0 |]
and g_obj_z = L.const_struct g_cont [| g_str; L.const_float g_dbl 0.0 |]
and g_arr_z = L.const_struct g_cont [| g_str; L.const_float g_dbl 0.0 |]
in


let build_sfunc sfunc =

  let (func, _) = StringMap.find sfunc.sname g_funtab
  in

  let builder = L.builder_at_end g_cont (L.entry_block func)
  in
  let vartab =
    let add_arg m n p =
      L.set_value_name n p;
      let v = L.build_alloca g_val n builder
      in
      ignore (L.build_store p v builder);
      StringMap.add n v m
    in
    List.fold_left2 add_arg StringMap.empty ("this" :: sfunc.sargs)
      (Array.to_list (L.params func))
  in

  let lcont =
  {
    parent = None;
    builder = builder;
    vartab = vartab;
  }
  in

  let rec get_var cont n =
    try Some (StringMap.find n cont.vartab)
    with Not_found ->
      match cont.parent with
      | Some p -> get_var p n
      | None -> None
  in

  let add_var cont n =
    let v = L.build_alloca g_val n cont.builder
    in
    let cont' = {cont with vartab = (StringMap.add n v cont.vartab)}
    in
    (cont', v)
  in

  let rec build_sexpr cont ((_, e) : sexpr) =
    match e with
    | SNullit _ -> (cont, g_null_z)
    | SBoolit (_, b) -> (cont, if b then g_bool_t else g_bool_f)
    | SNumlit (_, n) -> (cont, L.const_struct g_cont [| g_num; L.const_float g_dbl n |])
    | SStrlit (_, s) -> (cont, g_str_z)
    | SObjlit (_, fl) -> (cont, g_obj_z)
    | SArrlit (_, el) -> (cont, g_arr_z)
    | SId (_, s) ->
      let v = match (get_var cont s) with
      | Some x -> (cont, L.build_load x s cont.builder)
      | None -> (cont, g_void_z)
      in
      v
    | SUnop (_, _, _) -> (cont, g_null_z)
    | SBinop (_, _, _, _) -> (cont, g_null_z)
    | SAssign (_, s, e) ->
      let (cont', e') = build_sexpr cont e
      in
      let v = match (get_var cont' s) with
      | Some x ->
        ignore (L.build_store e' x cont'.builder);
        (cont', e')
      | None ->
        let (cont'', x') = add_var cont' s
        in
        ignore (L.build_store e' x' cont''.builder);
        (cont'', e')
      in
      v
    | SCall (_, f, el) ->
      (cont, g_null_z)
  in

  let add_terminal cont inst =
    match L.block_terminator (L.insertion_block cont.builder) with
    | Some _ -> ()
    | None -> ignore (inst cont.builder)
  in

  let rec build_sstmt cont sstmt =
    match sstmt with
    | SBlock (_, sl) ->
      let cont' = {cont with parent = Some cont; vartab = StringMap.empty}
      in
      let _ = List.fold_left build_sstmt cont' sl
      in
      cont
    | SExpr (_, e) ->
      let (cont', _) = build_sexpr cont e
      in
      cont'
    | SBreak _ -> cont
    | SContinue _ -> cont
    | SIf (_, e, s) -> cont
    | SIfElse (_, e, s1, s2) -> cont
    | SWhile (_, e, s) -> cont
    | SReturn (_, Some e) ->
      let (cont', v) = build_sexpr cont e
      in
      ignore (L.build_ret v cont'.builder);
      cont'
    | SReturn (_, None) ->
      ignore (L.build_ret g_void cont.builder);
      cont
  in

  let lcont' = build_sstmt lcont (SBlock (sfunc.spos, sfunc.sbody))
  in

  add_terminal lcont' (L.build_ret g_void)

in


List.iter build_sfunc sprogram.sfuncs;
g_mod

