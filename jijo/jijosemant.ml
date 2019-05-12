(*
 * JIJO semantic analyzer.
 *)

open Jijoast
open Jijosast

(* (line, char), function, message *)
exception SemantError of pos * string * string

module StringMap = Map.Make(String)


(* parsing context *)
type context = {
  parent: context option; (* enclosing (parent) context *)
  fname: string; (* current function name *)
  funtab: func StringMap.t; (* all functions in program *)
  symtab: typ option StringMap.t; (* variables already initialized in current function *)
  breakable: bool; (* if break/continue valid in current block (ex. in 'while' *)
  accessible: bool; (* if an id can be resolved at runtime, w/o symtab (ex. object.id) *)
  finished: bool; (* if uncondl break/continue/return already encountered in current block *)
}


let sprogram_of_program program = 


let is_typ t typ = match t with
  | Some x when x = typ -> true
  | None -> true
  | _ -> false
in

let is_typ_eq t1 t2 = match (t1, t2) with
  | (_, None) | (None, _) -> true
  | _ -> (t1 = t2)
in
let is_expr_id e = match e with
  | Id _ -> true
  | _ -> false
in
let is_expr_call e = match e with
  | Call _ -> true
  | _ -> false
in


let rec sexpr_of_expr cont expr =
  let sexpr_list_of_expr_list cont el =
    let add_expr (c, sel) e =
      let (c', e') = sexpr_of_expr c e
      in
      (c', e' :: sel)
    in
    List.fold_left add_expr (cont, []) el
  in
  let sfield_list_of_field_list cont fl =
    let add_field (c, sfl) (f, e) =
      let (c', e') = sexpr_of_expr c e
      in
      (c', (f, e') :: sfl)
    in
    List.fold_left add_field (cont, []) fl
  in
  let type_of_id pos id =
    if cont.accessible then
      None
    else
      try StringMap.find id cont.symtab
      with Not_found ->
        raise (SemantError (pos, cont.fname, "variable " ^ id ^ " may not have been initialized"))
  in
  match expr with
  | Nullit (p) -> (cont, (Some Null, SNullit p))
  | Boolit (p, x) -> (cont, (Some Bool, SBoolit (p, x)))
  | Numlit (p, x) -> (cont, (Some Number, SNumlit (p, x)))
  | Strlit (p, x) -> (cont, (Some String, SStrlit (p, x)))
  | Objlit (p, fl) ->
    let (cont', fl') = sfield_list_of_field_list cont fl
    in
    (cont', (Some Object, SObjlit (p, List.rev fl')))
  | Arrlit (p, el) ->
    let (cont', el') = sexpr_list_of_expr_list cont el
    in
    (cont', (Some Array, SArrlit (p, List.rev el')))
  | Id (p, x) -> (cont, (type_of_id p x, SId (p, x)))
  | Unop (p, e, o) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    let t' = match o with
      | Neg (_) when is_typ t Number -> Some Number
      | Not (_) when is_typ t Bool -> Some Bool
      | Len (_) when (is_typ t String) || (is_typ t Array) -> Some Number
      | _ -> raise (SemantError (p, cont.fname,
        "unary operator " ^ (Jijohelp.str_of_uop o) ^
        " cannot be applied to type " ^ (Jijohelp.str_of_typ t) ^
        " in expression: " ^ (Jijohelp.str_of_expr x)))
    in
    (cont', (t', SUnop(p, (t, e'), o)))
  | Binop (p, e1, o, e2) as x ->
    let (cont', (t1, e1')) = sexpr_of_expr cont e1
    in
    let (cont'', (t2, e2')) = sexpr_of_expr cont' e2
    in
    let t' = match o with
      | Add (_) when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Sub (_) when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Mult (_) when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Div (_) when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Concat (_) when (is_typ t1 String) && (is_typ t2 String) -> Some String
      | Equal (_) when is_typ_eq t1 t2 -> Some Bool
      | Nequal (_) when is_typ_eq t1 t2 -> Some Bool
      | Less (_) when is_typ_eq t1 t2 -> Some Bool
      | Lequal (_) when is_typ_eq t1 t2 -> Some Bool
      | Grtr (_) when is_typ_eq t1 t2 -> Some Bool
      | Grequal (_) when is_typ_eq t1 t2 -> Some Bool
      | And (_) when (is_typ t1 Bool) && (is_typ t2 Bool) -> Some Bool
      | Or (_) when (is_typ t1 Bool) && (is_typ t2 Bool) -> Some Bool
      | Is (_) -> Some Bool
      | Ind (_) when (t1 = Some(String)) && (is_typ t2 Number) -> Some String
      | Ind (_) when (is_typ t1 Array) && (is_typ t2 Number) -> None
      | Dot (_) when (is_expr_id e2) -> None
      | DotDot (_) when (is_expr_call e2) -> None
      | _ -> raise (SemantError(p, cont.fname,
        "binary operator " ^ (Jijohelp.str_of_bop o) ^
        " cannot be applied to types " ^ (Jijohelp.str_of_typ t1) ^
        " and " ^ (Jijohelp.str_of_typ t2) ^
        " in expression: " ^ (Jijohelp.str_of_expr x)))
    in
    (cont'', (t', SBinop(p, (t1, e1'), o, (t2, e2'))))
  | Assign (p, s, e) ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    let cont'' = {cont' with symtab = StringMap.add s None cont'.symtab}
    in
    (cont'', (t, SAssign(p, s, (t, e'))))
  | Call (p, f, el) ->
    let func = 
      try StringMap.find f cont.funtab
      with Not_found -> raise (SemantError(p, cont.fname, "undefined function: " ^ f))
    in
    let argc = List.length func.args
    in
    if List.length el != argc then
      raise (SemantError (p, cont.fname, "incorrect number of arguments in call: " ^ f))
    else
      let (cont', el') = sexpr_list_of_expr_list cont el
      in
      (cont', (None, SCall(p, f, (List.rev el'))))
in


let rec sstmt_list_of_stmt_list cont sl =
  match sl with
  | [] -> []
  | Block (_, sl) :: sl' -> sstmt_list_of_stmt_list cont (sl @ sl')
  | s :: sl ->
    let (cont', s') = sstmt_of_stmt cont s
    in s' :: sstmt_list_of_stmt_list cont' sl
and sstmt_of_stmt cont stmt =
  let fail_break s = 
     SemantError (Jijohelp.pos_of_stmt s, cont.fname,
       "statement cannot be used outside of a loop: " ^ (Jijohelp.str_of_stmt s))
  in
  let fail_cond t s =
     SemantError (Jijohelp.pos_of_stmt s, cont.fname,
      "expression of type " ^ (Jijohelp.str_of_typ t) ^
      " cannot be used as condition in: " ^ (Jijohelp.str_of_stmt s))
  in
  match stmt with
  | Block (p, sl) -> 
    let cont' =
      {cont with parent = Some cont; symtab = StringMap.empty; accessible = false}
    in
    (cont, SBlock(p, sstmt_list_of_stmt_list cont' sl))
  | Expr (p, e) ->
    let (cont', e') = sexpr_of_expr cont e
    in
    (cont', SExpr (p, e'))
  | Break (p) as x -> 
    if cont.breakable then ({cont with finished = true}, SBreak p)
    else raise (fail_break x)
  | Continue (p) as x -> 
    if cont.breakable then ({cont with finished = true}, SContinue p)
    else raise (fail_break x)
  | If (p, e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let (_, s') = sstmt_of_stmt cont' s
      in
      (cont', SIf (p, (t, e'), s'))
    else
      raise (fail_cond t x)
  | IfElse (p, e, s1, s2) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let (_, s1') = sstmt_of_stmt cont' s1
      and (_, s2') = sstmt_of_stmt cont' s2
      in
      (cont', SIfElse(p, (t, e'), s1', s2'))
    else
      raise (fail_cond t x)
  | While (p, e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let cont'' = {cont' with breakable = true}
      in
      let (_, s') = sstmt_of_stmt cont'' s
      in
      (cont', SWhile(p, (t, e'), s'))
    else
      raise (fail_cond t x)
  | Return (p, Some e) ->
    let (cont', e') = sexpr_of_expr cont e
    in
    ({cont' with finished = true}, SReturn (p, Some e'))
  | Return (p, None) -> ({cont with finished = true}, SReturn (p, None))
in


let sfunc_of_func cont func =
  let add_arg m a =
    if StringMap.mem a m then
      raise (SemantError (func.pos, func.name, "duplicate argument: " ^ a))
    else
      StringMap.add a None m
  in
  let symtab' = List.fold_left add_arg StringMap.empty func.args
  in
  let cont' = {cont with parent = Some cont; fname = func.name; symtab = symtab'}
  in
  {
    spos = func.pos;
    sname = func.name;
    sargs = func.args;
    sbody = sstmt_list_of_stmt_list cont' func.body
  }
in


let create_init_cont program =
  let add_func m f =
    if StringMap.mem f.name m then
      raise (SemantError (f.pos, f.name, "duplicate function"))
    else
      StringMap.add f.name f m
  in
  {
    parent = None;
    fname = "<init>";
    funtab = List.fold_left add_func StringMap.empty program.funcs;
    symtab = StringMap.empty;
    breakable = false;
    accessible = false;
    finished = false;
  }
in


{
  sfuncs = List.map (sfunc_of_func (create_init_cont program)) program.funcs
}

