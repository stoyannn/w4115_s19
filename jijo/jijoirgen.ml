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
let g_mod = L.create_module g_cont "jijo"
and g_i8 = L.i8_type g_cont
and g_i32 = L.i32_type g_cont
and g_dbl = L.double_type g_cont
in
let g_val = L.struct_type g_cont [| g_i8; g_dbl |]
and g_i8ptr = L.pointer_type g_i8
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
and (g_strtab) = Hashtbl.create 1024
and (g_idtab) = Hashtbl.create 1024
in

let get_add_field_id f =
  try Hashtbl.find g_idtab f
  with Not_found ->
    let i' = L.const_int g_i32 (Hashtbl.length g_idtab)
    in
    Hashtbl.add g_idtab f i'; i'
in

let g_void = L.const_int g_i8 0
and g_null = L.const_int g_i8 1
and g_bool = L.const_int g_i8 2
and g_num = L.const_int g_i8 3
and g_obj = L.const_int g_i8 5
and g_arr = L.const_int g_i8 6
in
let g_void_z = L.const_struct g_cont [| g_void; L.const_float g_dbl 0.0 |]
and g_null_z = L.const_struct g_cont [| g_null; L.const_float g_dbl 0.0 |]
and g_bool_t = L.const_struct g_cont [| g_bool; L.const_float g_dbl 1.0 |]
and g_bool_f = L.const_struct g_cont [| g_bool; L.const_float g_dbl 0.0 |]
and g_num_z = L.const_struct g_cont [| g_num; L.const_float g_dbl 0.0 |]
in

let g_binop_t = L.function_type g_val [| g_val; g_val |]
and g_unop_t = L.function_type g_val [| g_val |]
and g_new_t = L.function_type g_val [| g_i8 |]
and g_new2_t = L.function_type g_val [| g_i8ptr |]
and g_get_t = L.function_type g_val [| g_val; g_i32 |]
and g_set_t = L.function_type g_i32 [| g_val; g_i32; g_val |]
and g_set2_t = L.function_type g_i32 [| g_val; g_val; g_val |]
and g_print_t = L.function_type g_i32 [| g_val |]
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
and g_func_new_composite = L.declare_function "_func_new_composite" g_new_t g_mod
and g_func_new_string = L.declare_function "_func_new_string" g_new2_t g_mod
and g_func_get_element = L.declare_function "_func_get_element" g_get_t g_mod
and g_func_set_element = L.declare_function "_func_set_element" g_set_t g_mod
and g_binop_get_value = L.declare_function "_binop_get_value" g_binop_t g_mod
and g_func_set_value = L.declare_function "_func_set_value" g_set2_t g_mod
and g_unop_len = L.declare_function "_unop_len" g_unop_t g_mod
and g_binop_concat = L.declare_function "_binop_concat" g_binop_t g_mod
and g_func_print = L.declare_function "_func_print" g_print_t g_mod
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
      let v =
        try Hashtbl.find g_strtab s
        with Not_found ->
          let v' = L.build_global_stringptr s "_str_const" cont.builder
          in
          Hashtbl.add g_strtab s v'; v'
      in
      let s' = L.build_call g_func_new_string [| v |] "func_new_string_" cont.builder
      in
      (cont, s')
    | SObjlit (_, fl) ->
      let o = L.build_call g_func_new_composite [| g_obj |]
        "_func_new_composite_" cont.builder
      in
      let add_field c f =
        let (c', e') = build_sexpr c (snd f)
        in
        let i = get_add_field_id (fst f)
        in
        ignore (L.build_call g_func_set_element [| o; i; e' |]
          "_func_set_element_" cont.builder);
        c'
      in
      let cont' = List.fold_left add_field cont fl
      in
      (cont', o)
    | SArrlit (_, el) ->
      let o = L.build_call g_func_new_composite [| g_arr |]
        "_func_new_composite_" cont.builder
      in
      let add_element (c, i) e =
        let (c', e') = build_sexpr c e
        in
        let i' = L.const_int g_i32 i
        in
        ignore (L.build_call g_func_set_element [| o; i'; e' |]
          "_func_set_element_" cont.builder);
        (c', (i + 1))
      in
      let (cont', _) = List.fold_left add_element (cont, 0) el
      in
      (cont', o)
    | SId (_, s) -> 
      let v = match cont.this with
      | Some x ->
        let i = get_add_field_id s
        in
        L.build_call g_func_get_element [| x; i |] "_func_get_element_" cont.builder
      | None -> (
        match (get_var cont s) with
        | Some x -> L.build_load x s cont.builder
        | None -> g_void_z
      )
      in
      (cont, v)
    | SUnop (_, e, op) ->
      let (cont', e') = build_sexpr cont e
      in
      let arg = [| e' |]
      and bld = cont'.builder
      in
      let v = match op with
        | A.Neg _ -> L.build_call g_unop_uminus arg "_unop_uminus_" bld
        | A.Not _ -> L.build_call g_unop_not arg "_unop_not_" bld
        | A.Len _ -> L.build_call g_unop_len arg "_unop_len_" bld
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
        | A.Add _ -> L.build_call g_binop_plus arg "_binop_plus_" bld
        | A.Sub _ -> L.build_call g_binop_minus arg "_binop_minus_" bld
        | A.Mult _ -> L.build_call g_binop_mult arg "_binop_mult_" bld
        | A.Div _ -> L.build_call g_binop_div arg "_binop_div_" bld
        | A.Concat _ -> L.build_call g_binop_concat arg "_binop_concat_" bld
        | A.Equal _ -> L.build_call g_binop_equal arg "_binop_equal_" bld
        | A.Nequal _ -> L.build_call g_binop_nequal arg "_binop_nequal_" bld
        | A.Less _ -> L.build_call g_binop_less arg "_binop_less_" bld
        | A.Lequal _ -> L.build_call g_binop_lequal arg "_binop_lequal_" bld
        | A.Grtr _ -> L.build_call g_binop_grtr arg "_binop_grtr_" bld
        | A.Grequal _ -> L.build_call g_binop_grequal arg "_binop_grequal_" bld
        | A.And _ -> L.build_call g_binop_and arg "_binop_and_" bld
        | A.Or _ -> L.build_call g_binop_or arg "_binop_or_" bld
        | A.Is _ -> L.build_call g_binop_is arg "_binop_is_" bld
        | A.Ind _ -> L.build_call g_binop_get_value arg "_binop_get_value_" bld
        | A.Dot _ -> e2'
        | A.DotDot _ -> e2'
      in
      (cont'', v)
    | SAssign (_, s, None, None, e) ->
      let (cont', e') = build_sexpr cont e
      in
      let (cont'', v) =
        match (get_var cont' s) with
        | Some x -> (cont', x)
        | None -> add_var cont' s
      in
      ignore (L.build_store e' v cont''.builder);
      (cont'', e')
    | SAssign (_, s, Some f, _, e) ->
      let (cont', e') = build_sexpr cont e
      in
      let (cont'', v) =
        match (get_var cont' s) with
        | Some x -> (cont', L.build_load x s cont.builder)
        | None -> (* Semantic analyzer will not allow this, but let's try to handle it *)
          let (cont'', v') = add_var cont' s
          in
          let o = L.build_call g_func_new_composite [| g_obj |]
            "_func_new_composite_" cont''.builder
          in
          ignore (L.build_store o v' cont''.builder);
          (cont'', v')
      in
      let i = get_add_field_id f
      in
      ignore (L.build_call g_func_set_element [| v; i; e' |]
        "_func_set_element_" cont''.builder);
      (cont'', e')
    | SAssign (_, s, _, Some i, e) ->
      let (cont', i') = build_sexpr cont i
      in
      let (cont'', e') = build_sexpr cont' e
      in
      let (cont''', v) =
        match (get_var cont'' s) with
        | Some x -> (cont'', L.build_load x s cont.builder)
        | None -> (* Semantic analyzer will not allow this, but let's try to handle it *)
          let (cont''', v') = add_var cont'' s
          in
          let o = L.build_call g_func_new_composite [| g_arr |]
            "_func_new_composite_" cont'''.builder
          in
          ignore (L.build_store o v' cont'''.builder);
          (cont''', v')
      in
      ignore (L.build_call g_func_set_value [| v; i'; e' |]
        "_func_set_value_" cont'''.builder);
      (cont''', e')
    | SCall (_, "print", [e]) ->
      let (cont', e') = build_sexpr cont e
      in
      (cont', L.build_call g_func_print [| e' |] "_func_print_" cont'.builder)
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

  add_terminal lcont' (L.build_ret g_void_z)

in


List.iter build_sfunc sprogram.sfuncs;
g_mod

