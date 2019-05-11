open Jijoast
open Jijosast

module StringMap = Map.Make(String)

type context = {
  parent: context option;
  name: string;
  funtab: StringMap.t;
  symtab: StringMap.t;
  breakable: boolean; 
  accessible: boolean;
  finished: boolean;
}

let sprogram_of_program program = 

let fail name msg =
  Failure (name ^ ": " ^ msg)
in

let is_typ t typ = match t with
  | None | Some(typ) -> true
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
        raise (fail cont.name ("variable " ^ id ^ " may not have been initialized"))
  in
  match expr with
  | Nullit -> (cont, (Null, SNullit))
  | Boolit x -> (cont, (Bool, SBoolit x))
  | Numlit x -> (cont, (Number, Snumlit x))
  | Strlit x -> (cont, (String, SStrlit x))
  | Objlit x -> (cont, (Object, SObjlit x))
  | Arrlit x -> (cont, (Array, SArrlit x))
  | Id x -> (cont, (type_of_id x, SId x))
  | Unop(e, o) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    and t' = match o with
      | Neg when is_typ t Number -> Number
      | Not when is_typ t Bool -> Bool
      | Len when (is_typ t String) || (is_typ t Array) -> Number
      | _ -> raise (fail cont.name ("unary operator '" ^ (Jijohelp.str_of_uop o) ^
        "' cannot be applied to type '" ^ (Jijohelp.str_of_typ t) ^
        "' in expression: " ^ (Jijohelp.str_of_expr x)))
    in
    (cont', (t', SUnop(e', o)))
  | Binop(e1, o, e2) as x ->
    let (cont', (t1, e1')) = sexpr_of_expr cont e1
    and (cont'', (t2, e2')) = sexpr_of_expr cont' e2
    and t' = match o with
      | Add when (is_typ t1 Number) && (is_typ t2 Number) -> Number
      | Sub when (is_typ t1 Number) && (is_typ t2 Number) -> Number
      | Mult when (is_typ t1 Number) && (is_typ t2 Number) -> Number
      | Div when (is_typ t1 Number) && (is_typ t2 Number) -> Number
      | Concat when (is_typ t1 String) && (is_typ t2 String) -> String
      | Equal when is_typ_eq t1 t2 -> Bool
      | Nequal when is_typ_eq t1 t2 -> Bool
      | Less when is_typ_eq t1 t2 -> Bool
      | Lequal when is_typ_eq t1 t2 -> Bool
      | Grtr when is_typ_eq t1 t2 -> Bool
      | Grequal when is_typ_eq t1 t2 -> Bool
      | And when (is_typ t1 Bool) && (is_typ t2 Bool) -> Bool
      | Or when (is_typ t1 Bool) && (is_typ t2 Bool) -> Bool
      | Is -> Bool
      | Ind when (t1 = Some(String)) && (is_typ t2 Number) -> String
      | Ind when (is_typ t1 Array) && (is_typ t2 Number) -> None
      | Dot when (is_expr_id e2) -> None
      | DotDot when (is_expr_call e2) -> None
      | _ -> raise (Failure "Binary operator '" ^ (Jijohelp.str_of_bop o) ^
        "' cannot be applied to types '" ^ (Jijohelp.str_of_typ t1) ^
        "' and '" ^ (Jijohelp.str_of_typ t2) ^
        "' in expression: " ^ (Jijohelp.str_of_expr x))
    in
    (cont'', (t', SBinop((t1, e1'), o, (t2, e2'))))
  | Assign(s, e) ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    and cont'' = {cont' with symtab = StringMap.add s None cont'.symtab}
    in
    (cont'', (t, SAssign(s, e')))
  | Call(f, el) as x ->
    let func = 
      try StringMap.find f cont.funtab
      with Not_found -> raise (fail cont.name ("undefined function: " ^ f))
    and argc = List.length func.args
    in
    if List.length el != argc then
      raise (fail cont.name ("incorrect number of arguments in call: " ^ f))
    else
      let (cont', el') = sexpr_list_of_expr_list cont el
      in
      (cont', List.rev el')
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
  let fail_break e = fail cont.name ("statement cannot be used outside of a loop: " ^
    (Jijohelp.str_of_expr e))
  in
  let fail_cond t e = fail cont.name ("expression of type " ^ (Jijohelp.str_of_typ t) ^
    " cannot be used as condition in: " ^ (Jijohelp.str_of_expr e))
  in
  match stmt with
  | Block sl -> 
    let cont' =
      {cont with parent = Some(cont); symtab = StringMap.empty; accessible = false}
    in
    (cont, SBlock(sstmt_list_of_stmt_list cont' sl))
  | Expr e -> SExpr(sexpr_of_expr cont e)
  | Break as x -> 
    if cont.breakable then ({cont with finished = true}, SBreak)
    else raise (fail_break x)
  | Continue as x -> 
    if cont.breakable then ({cont with finished = true}, SContinue)
    else raise (fail_break x)
  | If(e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      (cont', SIf(e', sstmt_of_stmt cont' s))
    else
      raise (fail_cond t x)
  | IfElse(e, s1, s2) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      (cont', SIfElse(e', sstmt_of_stmt cont' s1, sstmt_of_stmt cont' s2))
    else
      raise (fail_cond t x)
  | While(e, s) as x ->
    let (cont', (t, e')) = sexpr_of_expr cont e
    in
    if is_typ t Bool then
      let cont'' = {cont' with breakable = true}
      in
      (cont', SWhile(e', sstmt_of_stmt cont'' s))
    else
      raise (fail_cond t x)
  | Return Some(e) ->
    let (cont', e') = sexpr_of_expr cont e
    in
    ({cont' with finished = true}, SReturn e')
  | Return None -> ({cont with finished = true}, SReturn None)
in

(* OK *)
let sfunc_of_func cont func =
  let add_arg m a =
    if StringMap.mem a m then raise (fail func.name ("duplicate argument: " ^ a))
    else StringMap.add a None m
  in
  let symtab' = List.fold_left add_arg StringMap.empty func.args
  and cont' = {cont with parent = Some(cont); name = func.name; symtab = symtab'}
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
    name = "<init>";
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

