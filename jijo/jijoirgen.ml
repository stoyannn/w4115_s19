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
  this: L.llvalue option;
}


let llmodule_of_sprogram sprogram =


let g_cont = L.global_context ()
in
let g_mod = L.create_module g_cont "Jijo"
and g_i8 = L.i8_type g_cont
and g_i32 = L.i32_type g_cont
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

and g_strtab =
  let rec add_sexpr m ((_, sx) : sexpr) =
    match sx with
    | SStrlit (_, s) when not (StringMap.mem s m) ->
      let v = (L.define_global "_const_str" (L.const_stringz g_cont s) g_mod)
      in
      StringMap.add s v m
    | SObjlit (_, fl) -> List.fold_left add_sexpr m (List.map snd fl)
    | SArrlit (_, el) -> List.fold_left add_sexpr m el
    | SUnop (_, e, _) -> add_sexpr m e
    | SBinop (_, e1, _, e2) -> add_sexpr (add_sexpr m e1) e2
    | SAssign (_, _, e) -> add_sexpr m e
    | SCall (_, _, el) -> List.fold_left add_sexpr m el
    | _ -> m
  and add_sstmt m sstmt =
    match sstmt with
    | SBlock (_, sl) -> List.fold_left add_sstmt m sl
    | SExpr (_, e) -> add_sexpr m e
    | SIf (_, e, _) -> add_sexpr m e
    | SIfElse (_, e, _, _) -> add_sexpr m e
    | SWhile (_, e, _) -> add_sexpr m e
    | SReturn (_, Some e) -> add_sexpr m e
    | _ -> m
  and add_sfunc m sfunc =
    List.fold_left add_sstmt m sfunc.sbody
  in
  List.fold_left add_sfunc StringMap.empty sprogram.sfuncs
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

let g_printf =
  let printf_t = L.var_arg_function_type g_i32 [| L.pointer_type g_i8 |]
  in
  L.declare_function "printf" printf_t g_mod
in

let g_binop_t = L.function_type g_val [| g_val; g_val |]
and g_unop_t = L.function_type g_val [| g_val |]
in
let g_binop_plus = L.declare_function "_binop_plus" g_binop_t g_mod
and g_binop_minus = L.declare_function "_binop_minus" g_binop_t g_mod
and g_binop_mult = L.declare_function "_binop_mult" g_binop_t g_mod
and g_binop_div = L.declare_function "_binop_div" g_binop_t g_mod
and g_unop_uminus = L.declare_function "_unop_uminus" g_unop_t g_mod
and g_binop_equal = L.declare_function "_binop_equal" g_binop_t g_mod
and g_binop_nequal = L.declare_function "_binop_nequal" g_binop_t g_mod
and g_binop_less = L.declare_function "_binop_less" g_binop_t g_mod
and g_binop_lequal = L.declare_function "_binop_lequal" g_binop_t g_mod
and g_binop_grtr = L.declare_function "_binop_grtr" g_binop_t g_mod
and g_binop_grequal = L.declare_function "_binop_grequal" g_binop_t g_mod
and g_binop_and = L.declare_function "_binop_and" g_binop_t g_mod
and g_binop_or = L.declare_function "_binop_or" g_binop_t g_mod
and g_unop_not = L.declare_function "_unop_not" g_unop_t g_mod
and g_binop_is = L.declare_function "_binop_is" g_binop_t g_mod
and g_binop_index = L.declare_function "_binop_index" g_binop_t g_mod
and g_unop_len = L.declare_function "_unop_len" g_unop_t g_mod
and g_binop_concat = L.declare_function "_binop_concat" g_binop_t g_mod
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
    this = None;
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
    | SStrlit (_, s) ->
      let v = StringMap.find s g_strtab
      in
      (cont, L.const_struct g_cont [| g_str; v |])
    | SObjlit (_, fl) -> (cont, g_obj_z)
    | SArrlit (_, el) -> (cont, g_arr_z)
    | SId (_, s) ->
      let v = match (get_var cont s) with
      | Some x -> (cont, L.build_load x s cont.builder)
      | None -> (cont, g_void_z)
      in
      v
    | SUnop (_, e, op) ->
      let (cont', e') = build_sexpr cont e
      in
      let arg = [| e' |]
      and bld = cont'.builder
      in
      let v = match op with
        | A.Neg _ -> L.build_call g_unop_uminus arg "_unop_uminus_res" bld
        | A.Not _ -> L.build_call g_unop_not arg "_unop_not_res" bld
        | A.Len _ -> L.build_call g_unop_len arg "_unop_len_res" bld
      in
      (cont', v)
    | SBinop (_, e1, op, e2) ->
      let (cont', e1') = build_sexpr cont e1
      in
      let (cont'', e2') =
        match op with
        | A.Dot _ | A.DotDot _ -> build_sexpr {cont' with this = Some e1'} e2
        | _ -> build_sexpr cont' e2
      in
      let arg = [| e1'; e2' |]
      and bld = cont''.builder
      in
      let v = match op with
        | A.Add _ -> L.build_call g_binop_plus arg "_binop_plus_res" bld
        | A.Sub _ -> L.build_call g_binop_minus arg "_binop_minus_res" bld
        | A.Mult _ -> L.build_call g_binop_mult arg "_binop_mult_res" bld
        | A.Div _ -> L.build_call g_binop_div arg "_binop_div_res" bld
        | A.Concat _ -> L.build_call g_binop_concat arg "_binop_concat_res" bld
        | A.Equal _ -> L.build_call g_binop_equal arg "_binop_equal_res" bld
        | A.Nequal _ -> L.build_call g_binop_nequal arg "_binop_nequal_res" bld
        | A.Less _ -> L.build_call g_binop_less arg "_binop_less_res" bld
        | A.Lequal _ -> L.build_call g_binop_lequal arg "_binop_lequal_res" bld
        | A.Grtr _ -> L.build_call g_binop_grtr arg "_binop_grtr_res" bld
        | A.Grequal _ -> L.build_call g_binop_grequal arg "_binop_grequal_res" bld
        | A.And _ -> L.build_call g_binop_and arg "_binop_and_res" bld
        | A.Or _ -> L.build_call g_binop_or arg "_binop_or_res" bld
        | A.Is _ -> L.build_call g_binop_is arg "_binop_is_res" bld
        | A.Ind _ -> L.build_call g_binop_index arg "_binop_index_res" bld
        | A.Dot _ -> e2'
        | A.DotDot _ -> e2'
      in
      (cont'', v)
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
      let (fdef, fdec) = StringMap.find f g_funtab
      in
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
(*
      let while_bb = L.append_block g_cont "while" func
      in
      let build_br_while = L.build_br while_bb
      in
      ignore (build_br_while cont.builder);

      let while_builder = L.builder_at_end g_cont while_bb
      in
      let bool_val = build_expr ({cont with builder = while_builder}) e
      in
      let body_bb = L.append_block g_cont "while_body" func
      in
      add_terminal (build_stmt (L.builder_at_end g_cont body_bb) body) build_br_while;

      let end_bb = L.append_block g_cont "while_end" func
      in
      ignore (L.build_cond_br bool_val body_bb end_bb while_builder);
      L.builder_at_end context end_bb
*)
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

