type bop =
  | Add | Sub | Mult | Div
  | Equal | Nequal | Less | Lequal | Grtr | Grequal
  | And | Or | Is
  | Ind
  | Dot | Dotdot

type uop =
  | Neg | Not | Len

type expr =
  | Nullit
  | Boolit of bool
  | Numlit of float
  | Strlit of string
  | Objlit of (string * expr) list
  | Arrlit of expr list
  | Id of string
  | Unop of expr * uop
  | Binop of expr * bop * expr
  | Assign of string * expr
  | Call of string * expr list

type stmt =
  | Block of stmt list
  | Expr of expr
  | Break
  | Continue
  | If of expr * stmt
  | IfElse of expr * stmt * stmt
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

