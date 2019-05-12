(*
 * JIJO compiler helper functions.
 *)

open Jijoast
open Jijosast

let str_of_typ = function
  | Some Null -> "null"
  | Some Bool -> "boolean"
  | Some Number -> "number"
  | Some String -> "string"
  | Some Object -> "object"
  | Some Array -> "array"
  | None -> "unknown"

let str_of_uop = function
  | Neg _ -> "-"
  | Not _ -> "!"
  | Len _ -> "[?]"

let str_of_bop = function
  | Add _ -> "+"
  | Sub _ -> "-"
  | Mult _ -> "*"
  | Concat _ -> "&"
  | Div _ -> "/"
  | Equal _ -> "=="
  | Nequal _ -> "!="
  | Less _ -> "<"
  | Lequal _ -> "<="
  | Grtr _ -> ">"
  | Grequal _ -> ">="
  | And _ -> "&&"
  | Or _ -> "||"
  | Is _ -> "is"
  | Ind _ -> ""
  | Dot _ -> "."
  | DotDot _ -> ".."

let rec str_of_expr = function
  | Nullit _ -> "null"
  | Boolit (_, true) -> "true"
  | Boolit (_, false) -> "false"
  | Numlit (_, n) -> string_of_float n
  | Strlit (_, s) -> "\"" ^ s ^ "\""
  | Objlit (_, fl) -> "<obj> {" ^
    (String.concat ", " (List.map (fun f -> (fst f) ^ ":" ^ (str_of_expr (snd f))) fl)) ^
    "}"
  | Arrlit (_, el) -> "<arr> [" ^
    (String.concat ", " (List.map str_of_expr el)) ^
    "]"
  | Id (_, s) -> s
  | Unop (_, e, o) when (match o with Len _ -> true | _ -> false) ->
    (str_of_expr e) ^ " " ^ (str_of_uop o)
  | Unop (_, e, o) -> (str_of_uop o) ^ " " ^ (str_of_expr e)
  | Binop (_, e1, o, e2) when (match o with Ind _ -> true | _ -> false) ->
    (str_of_expr e1) ^ " [" ^ (str_of_expr e2) ^ "]"
  | Binop (_, e1, o, e2) -> (str_of_expr e1) ^ " " ^ (str_of_bop o) ^ " " ^ (str_of_expr e2)
  | Assign (_, s, e) -> s ^ " = " ^ (str_of_expr e)
  | Call (_, s, el) -> s ^ "(" ^ (String.concat ", " (List.map str_of_expr el)) ^ ")"

let rec str_of_sexpr = function
  | (_, SNullit _) -> "null"
  | (_, SBoolit (_, true)) -> "true"
  | (_, SBoolit (_, false)) -> "false"
  | (_, SNumlit (_, n)) -> string_of_float n
  | (_, SStrlit (_, s)) -> "\"" ^ s ^ "\""
  | (_, SObjlit (_, fl)) -> "<obj> {" ^
    (String.concat ", " (List.map (fun f -> (fst f) ^ ":" ^ (str_of_sexpr (snd f))) fl)) ^
    "}"
  | (_, SArrlit(_, el)) -> "<arr> [" ^
    (String.concat ", " (List.map str_of_sexpr el)) ^
    "]"
  | (_, SId (_, s)) -> s
  | (_, SUnop (_, e, o)) when (match o with Len _ -> true | _ -> false) ->
    (str_of_sexpr e) ^ " " ^ (str_of_uop o)
  | (_, SUnop (_, e, o)) -> (str_of_uop o) ^ " " ^ (str_of_sexpr e)
  | (_, SBinop (_, e1, o, e2)) when (match o with Ind _ -> true | _ -> false) ->
    (str_of_sexpr e1) ^ " [" ^ (str_of_sexpr e2) ^ "]"
  | (_, SBinop (_, e1, o, e2)) -> (str_of_sexpr e1) ^ " " ^ (str_of_bop o) ^ " " ^ (str_of_sexpr e2)
  | (_, SAssign (_, s, e)) -> s ^ " = " ^ (str_of_sexpr e)
  | (_, SCall (_, s, el)) -> s ^ "(" ^ (String.concat ", " (List.map str_of_sexpr el)) ^ ")"

let rec str_of_stmt = function
  | Block (_, sl) -> "{\n" ^ (String.concat "" (List.map str_of_stmt sl)) ^ "}\n"
  | Expr (_, e) -> (str_of_expr e) ^ ";\n"
  | Break (_) -> "break;\n"
  | Continue (_) -> "continue;\n"
  | If (_, e, s) -> "if (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s)
  | IfElse (_, e, s1, s2) -> "if (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s1) ^
    "else\n" ^ (str_of_stmt s2)
  | While (_, e, s) -> "while (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s)
  | Return (_, Some e) -> "return " ^ (str_of_expr e) ^ ";\n"
  | Return (_, None) -> "return;\n"

let rec str_of_sstmt = function
  | SBlock (_, sl) -> "{\n" ^ (String.concat "" (List.map str_of_sstmt sl)) ^ "}\n"
  | SExpr (_, e) -> (str_of_sexpr e) ^ ";\n"
  | SBreak _ -> "break;\n"
  | SContinue _ -> "continue;\n"
  | SIf (_, e, s) -> "if (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s)
  | SIfElse (_, e, s1, s2) -> "if (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s1) ^
    "else\n" ^ (str_of_sstmt s2)
  | SWhile (_, e, s) -> "while (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s)
  | SReturn (_, Some e) -> "return " ^ (str_of_sexpr e) ^ ";\n"
  | SReturn (_, None) -> "return;\n"

let str_of_func f =
  f.name ^ "(" ^ (String.concat ", " f.args) ^
  ")\n{\n" ^ (String.concat "" (List.map str_of_stmt f.body)) ^ "}\n"

let str_of_sfunc f =
  f.sname ^ "(" ^ (String.concat ", " f.sargs) ^
  ")\n{\n" ^ (String.concat "" (List.map str_of_sstmt f.sbody)) ^ "}\n"

let str_of_program p =
  String.concat "" (List.map str_of_func p.funcs)

let str_of_sprogram p =
  String.concat "" (List.map str_of_sfunc p.sfuncs)

