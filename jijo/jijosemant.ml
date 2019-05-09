open Ast
open Sast

let is_typ t typ = match t with
  | None
  | Some(typ) -> true
  | _ -> false
in

let is_typ_eq t1 t2 = match (t1, t2) with
  | (_, None)
  | (None, _) -> true
  | _ -> (t1 = t2)
in

let rec sexpr_of_expr = function
  | Nullit -> (Null, SNullit)
  | Boolit x -> (Bool, SBoolit x)
  | Numlit x -> (Number, Snumlit x)
  | Strlit x -> (String, SStrlit x)
  | Objlit x -> (Object, SObjlit x)
  | Arrlit x -> (Array, SArrlit x)
  | Id x -> sexpr_of_id x
  | Unop(e, o) as x ->
    let (t, e') = sexpr_of_expr e
    and t' = match o with
      | Neg when is_typ t Number -> Number
      | Not when is_typ t Bool -> Bool
      | Len when (is_typ t String) || (is_typ t Array) -> Number
      | _ -> raise (Failure "Unary operator '" ^ (Jijohelp.str_of_uop o) ^
        "' cannot be applied to type '" ^ (Jijohelp.str_of_typ t) ^
        "' in expression: " ^ (Jijohelp.str_of_expr x))
    in
    (t', SUnop(e', o))
  | Binop(e1, o, e2) as x ->
    let (t1, e1') = sexpr_of_expr e1
    and let (t2, e2') = sexpr_of_expr e2
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
      | _ -> raise (Failure "Binary operator '" ^ (Jijohelp.str_of_bop o) ^
        "' cannot be applied to types '" ^ (Jijohelp.str_of_typ t1) ^
        "' and '" ^ (Jijohelp.str_of_typ t2) ^
        "' in expression: " ^ (Jijohelp.str_of_expr x))
    in
    (t', SBinop((t1, e1'), o, (t2, e2')))
  | Assign(s, e) ->
    let (t, e') = sexpr_of_expr e
    in
    (t, SAssign(s, e'))
  | Call(f, a) as x ->
    let
