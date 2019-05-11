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
  | Neg -> "-"
  | Not -> "!"
  | Len -> "[?]"

let str_of_bop = function
  | Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Concat -> "&"
  | Div -> "/"
  | Equal -> "=="
  | Nequal -> "!="
  | Less -> "<"
  | Lequal -> "<="
  | Grtr -> ">"
  | Grequal -> ">="
  | And -> "&&"
  | Or -> "||"
  | Is -> "is"
  | Ind -> ""
  | Dot -> "."
  | DotDot -> ".."

let rec str_of_expr = function
  | Nullit -> "null"
  | Boolit(true) -> "true"
  | Boolit(false) -> "false"
  | Numlit(n) -> string_of_float n
  | Strlit(s) -> "\"" ^ s ^ "\""
  | Objlit(fl) -> "<obj> {" ^
    (String.concat ", " (List.map (fun f -> (fst f) ^ ":" ^ (str_of_expr (snd f))) fl)) ^
    "}"
  | Arrlit(el) -> "<arr> [" ^
    (String.concat ", " (List.map str_of_expr el)) ^
    "]"
  | Id(s) -> s
  | Unop(e, o) when o = Len -> (str_of_expr e) ^ " " ^ (str_of_uop o)
  | Unop(e, o) -> (str_of_uop o) ^ " " ^ (str_of_expr e)
  | Binop(e1, o, e2) when o = Ind -> (str_of_expr e1) ^ " [" ^ (str_of_expr e2) ^ "]"
  | Binop(e1, o, e2) -> (str_of_expr e1) ^ " " ^ (str_of_bop o) ^ " " ^ (str_of_expr e2)
  | Assign(s, e) -> s ^ " = " ^ (str_of_expr e)
  | Call(s, el) -> s ^ "(" ^ (String.concat ", " (List.map str_of_expr el)) ^ ")"

let rec str_of_sexpr = function
  | (_, SNullit) -> "null"
  | (_, SBoolit(true)) -> "true"
  | (_, SBoolit(false)) -> "false"
  | (_, SNumlit(n)) -> string_of_float n
  | (_, SStrlit(s)) -> "\"" ^ s ^ "\""
  | (_, SObjlit(fl)) -> "<obj> {" ^
    (String.concat ", " (List.map (fun f -> (fst f) ^ ":" ^ (str_of_sexpr (snd f))) fl)) ^
    "}"
  | (_, SArrlit(el)) -> "<arr> [" ^
    (String.concat ", " (List.map str_of_sexpr el)) ^
    "]"
  | (_, SId(s)) -> s
  | (_, SUnop(e, o)) when o = Len -> (str_of_sexpr e) ^ " " ^ (str_of_uop o)
  | (_, SUnop(e, o)) -> (str_of_uop o) ^ " " ^ (str_of_sexpr e)
  | (_, SBinop(e1, o, e2)) when o = Ind -> (str_of_sexpr e1) ^ " [" ^ (str_of_sexpr e2) ^ "]"
  | (_, SBinop(e1, o, e2)) -> (str_of_sexpr e1) ^ " " ^ (str_of_bop o) ^ " " ^ (str_of_sexpr e2)
  | (_, SAssign(s, e)) -> s ^ " = " ^ (str_of_sexpr e)
  | (_, SCall(s, el)) -> s ^ "(" ^ (String.concat ", " (List.map str_of_sexpr el)) ^ ")"

let rec str_of_stmt = function
  | Block(sl) -> "{\n" ^ (String.concat "" (List.map str_of_stmt sl)) ^ "}\n"
  | Expr(e) -> (str_of_expr e) ^ ";\n"
  | Break -> "break;\n"
  | Continue -> "continue;\n"
  | If(e, s) -> "if (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s)
  | IfElse(e, s1, s2) -> "if (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s1) ^
    "else\n" ^ (str_of_stmt s2)
  | While(e, s) -> "while (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s)
  | Return(Some e) -> "return " ^ (str_of_expr e) ^ ";\n"
  | Return(None) -> "return;\n"

let rec str_of_sstmt = function
  | SBlock(sl) -> "{\n" ^ (String.concat "" (List.map str_of_sstmt sl)) ^ "}\n"
  | SExpr(e) -> (str_of_sexpr e) ^ ";\n"
  | SBreak -> "break;\n"
  | SContinue -> "continue;\n"
  | SIf(e, s) -> "if (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s)
  | SIfElse(e, s1, s2) -> "if (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s1) ^
    "else\n" ^ (str_of_sstmt s2)
  | SWhile(e, s) -> "while (" ^ (str_of_sexpr e) ^ ")\n" ^ (str_of_sstmt s)
  | SReturn(Some e) -> "return " ^ (str_of_sexpr e) ^ ";\n"
  | SReturn(None) -> "return;\n"

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

