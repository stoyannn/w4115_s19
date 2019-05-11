open Jijoast
open Jijosast

module StringMap = Map.Make(String)

type context = {
  parent: context option;
  fname: string;
  funtab: func StringMap.t;
  symtab: typ option StringMap.t;
  breakable: bool; 
  accessible: bool;
  finished: bool;
}

let sprogram_of_program program = 

let fail name msg =
  Failure (name ^ ": " ^ msg)
in

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

let rec sexpr_list_of_expr_list cont el =
  let add_expr (c, sel) e =
    let (c', se) = sexpr_of_expr c e
    in
    (c', se :: sel)
  in
  List.fold_left add_expr (cont, []) el

and sexpr_of_expr cont expr =
  let type_of_id id =
    if cont.accessible then
      None
    else
      try StringMap.find id cont.symtab
      with Not_found ->
        raise (fail cont.fname ("variable " ^ id ^ " may not have been initialized"))
  in
  match expr with
  | Nullit -> (cont, (Some Null, SNullit))
  | Boolit x -> (cont, (Some Bool, SBoolit x))
  | Numlit x -> (cont, (Some Number, SNumlit x))
  | Strlit x -> (cont, (Some String, SStrlit x))
(*
  | Objlit x -> (cont, (Object, SObjlit x))
  | Arrlit x -> (cont, (Array, SArrlit x))
*)
  | Id x -> (cont, (type_of_id x, SId x))
  | Unop(e, o) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    let t' = match o with
      | Neg when is_typ t Number -> Some Number
      | Not when is_typ t Bool -> Some Bool
      | Len when (is_typ t String) || (is_typ t Array) -> Some Number
      | _ -> raise (fail cont.fname ("unary operator " ^ (Jijohelp.str_of_uop o) ^
        " cannot be applied to type " ^ (Jijohelp.str_of_typ t) ^
        " in expression: " ^ (Jijohelp.str_of_expr x)))
    in
    (cont', (t', SUnop((t, e'), o)))
  | Binop(e1, o, e2) as x ->
    let (cont', (t1, e1')) = sexpr_of_expr cont e1
    in
    let (cont'', (t2, e2')) = sexpr_of_expr cont' e2
    in
    let t' = match o with
      | Add when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Sub when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Mult when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Div when (is_typ t1 Number) && (is_typ t2 Number) -> Some Number
      | Concat when (is_typ t1 String) && (is_typ t2 String) -> Some String
      | Equal when is_typ_eq t1 t2 -> Some Bool
      | Nequal when is_typ_eq t1 t2 -> Some Bool
      | Less when is_typ_eq t1 t2 -> Some Bool
      | Lequal when is_typ_eq t1 t2 -> Some Bool
      | Grtr when is_typ_eq t1 t2 -> Some Bool
      | Grequal when is_typ_eq t1 t2 -> Some Bool
      | And when (is_typ t1 Bool) && (is_typ t2 Bool) -> Some Bool
      | Or when (is_typ t1 Bool) && (is_typ t2 Bool) -> Some Bool
      | Is -> Some Bool
      | Ind when (t1 = Some(String)) && (is_typ t2 Number) -> Some String
      | Ind when (is_typ t1 Array) && (is_typ t2 Number) -> None
      | Dot when (is_expr_id e2) -> None
      | DotDot when (is_expr_call e2) -> None
      | _ -> raise (fail cont.fname ("binary operator " ^ (Jijohelp.str_of_bop o) ^
        " cannot be applied to types " ^ (Jijohelp.str_of_typ t1) ^
        " and " ^ (Jijohelp.str_of_typ t2) ^
        " in expression: " ^ (Jijohelp.str_of_expr x)))
    in
    (cont'', (t', SBinop((t1, e1'), o, (t2, e2'))))
  | Assign(s, e) ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    let cont'' = {cont' with symtab = StringMap.add s None cont'.symtab}
    in
    (cont'', (t, SAssign(s, (t, e'))))
  | Call(f, el) ->
    let func = 
      try StringMap.find f cont.funtab
      with Not_found -> raise (fail cont.fname ("undefined function: " ^ f))
    in
    let argc = List.length func.args
    in
    if List.length el != argc then
      raise (fail cont.fname ("incorrect number of arguments in call: " ^ f))
    else
      let (cont', el') = sexpr_list_of_expr_list cont el
      in
      (cont', (None, SCall(f, (List.rev el'))))
in

(* OK *)
let rec sstmt_list_of_stmt_list cont sl =
  match sl with
  | [] -> []
  | Block sl :: sl' -> sstmt_list_of_stmt_list cont (sl @ sl')
  | s :: sl ->
    let (cont', s') = sstmt_of_stmt cont s
    in s' :: sstmt_list_of_stmt_list cont' sl

(* OK *)
and sstmt_of_stmt cont stmt =
  let fail_break s = fail cont.fname ("statement cannot be used outside of a loop: " ^
    (Jijohelp.str_of_stmt s))
  in
  let fail_cond t s = fail cont.fname ("expression of type " ^ (Jijohelp.str_of_typ t) ^
    " cannot be used as condition in: " ^ (Jijohelp.str_of_stmt s))
  in
  match stmt with
  | Block sl -> 
    let cont' =
      {cont with parent = Some cont; symtab = StringMap.empty; accessible = false}
    in
    (cont, SBlock(sstmt_list_of_stmt_list cont' sl))
  | Expr e ->
    let (cont', e') = sexpr_of_expr cont e
    in
    (cont', SExpr e')
  | Break as x -> 
    if cont.breakable then ({cont with finished = true}, SBreak)
    else raise (fail_break x)
  | Continue as x -> 
    if cont.breakable then ({cont with finished = true}, SContinue)
    else raise (fail_break x)
  | If (e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let (_, s') = sstmt_of_stmt cont' s
      in
      (cont', SIf ((t, e'), s'))
    else
      raise (fail_cond t x)
  | IfElse (e, s1, s2) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let (_, s1') = sstmt_of_stmt cont' s1
      and (_, s2') = sstmt_of_stmt cont' s2
      in
      (cont', SIfElse((t, e'), s1', s2'))
    else
      raise (fail_cond t x)
  | While (e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let cont'' = {cont' with breakable = true}
      in
      let (_, s') = sstmt_of_stmt cont'' s
      in
      (cont', SWhile((t, e'), s'))
    else
      raise (fail_cond t x)
  | Return (Some e) ->
    let (cont', e') = sexpr_of_expr cont e
    in
    ({cont' with finished = true}, SReturn (Some e'))
  | Return None -> ({cont with finished = true}, SReturn None)
in

(* OK *)
let sfunc_of_func cont func =
  let add_arg m a =
    if StringMap.mem a m then raise (fail func.name ("duplicate argument: " ^ a))
    else StringMap.add a None m
  in
  let symtab' = List.fold_left add_arg StringMap.empty func.args
  in
  let cont' = {cont with parent = Some cont; fname = func.name; symtab = symtab'}
  in
  {
    sname = func.name;
    sargs = func.args;
    sbody = sstmt_list_of_stmt_list cont' func.body
  }
in

(* OK *)
let create_init_cont program =
  let add_func m f =
    if StringMap.mem f.name m then raise (fail f.name "duplicate function")
    else StringMap.add f.name f m
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

