open Jijoast

let str_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
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
  | Dot -> "."
  | Dotdot -> ".."

let rec str_of_expr = function
  | Boolit(true) -> "true"
  | Boolit(false) -> "false"
  | Numlit(n) -> string_of_float n
  | Strlit(s) -> "\"" ^ s ^ "\""
  | Nullit -> "null"
  | Objlit(fl) -> "{" ^ (String.concat ", " (List.map (fun f -> (fst f) ^ ":" ^ (str_of_expr (snd f))) fl)) ^ "}"
  | Arrlit(el) -> "[" ^ (String.concat ", " (List.map str_of_expr el)) ^ "]"
  | Id(s) -> s
  | Binop(e1, o, e2) -> (str_of_expr e1) ^ " " ^ (str_of_op o) ^ " " ^ (str_of_expr e2)
  | Assign(s, e) -> s ^ " = " ^ (str_of_expr e)
  | Call(s, el) -> s ^ "(" ^ (String.concat ", " (List.map str_of_expr el)) ^ ")"

let rec str_of_stmt = function
  | Block(sl) -> "{\n" ^ (String.concat "" (List.map str_of_stmt sl)) ^ "}\n"
  | Expr(e) -> (str_of_expr e) ^ ";\n"
  | Break -> "break;\n"
  | Continue -> "continue;\n"
  | If(e, s1, s2) -> "if (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s1) ^ "else\n" ^ (str_of_stmt s2)
  | While(e, s) -> "while (" ^ (str_of_expr e) ^ ")\n" ^ (str_of_stmt s)
  | Return(Some e) -> "return " ^ (str_of_expr e) ^ ";\n"
  | Return(None) -> "return;\n"

let str_of_func f =
  f.name ^ "(" ^ (String.concat ", " f.args) ^ ")\n{\n" ^ (String.concat "" (List.map str_of_stmt f.body)) ^ "}\n"

let str_of_program funcs =
  String.concat "" (List.map str_of_func funcs)
