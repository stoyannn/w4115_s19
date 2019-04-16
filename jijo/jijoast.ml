type op = Add | Sub | Mult | Div | Equal | Nequal | Less | Lequal | Grtr | Grequal | And | Or | Is | Dot | Dotdot

(* Unused for now *)
type typ = Bool | Number | String | Null | Object | Array

type expr =
  | Boolit of bool
  | Numlit of float
  | Strlit of string
  | Nullit
  | Objlit of (string * expr) list
  | Arrlit of expr list
  | Id of string
  | Binop of expr * op * expr
  | Assign of string * expr
  | Call of string * expr list

type stmt =
  | Block of stmt list
  | Expr of expr
  | Break
  | Continue
  | If of expr * stmt * stmt
  | While of expr * stmt
  | Return of expr option

type func = {
  name: string;
  args: string list;
  body: stmt list;
}

type program = {
  funcs: func list;
}
