type op = Add | Sub | Equal | Neq | Less | And | Or

type typ = Null | Bool | Number | String | Array | Object

type expr =
  | Nullit
  | Boolit of bool
  | Numlit of float
  | Strlit of string
  | Arrlit of expr list
  | Objlit of (string * expr) list
  | Id of string
  | Binop of expr * op * expr
  | Assign of string * expr

type stmt =
  | Block of stmt list
  | Expr of expr
  | If of expr * stmt * stmt
  | While of expr * stmt

type func = {
  body: stmt list;
}

type program = {
  funcs: (string * func) list;
}

