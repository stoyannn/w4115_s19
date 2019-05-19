(*
 * JIJO AST nodes.
 *)

(* (line, number) position in souce file *)
type pos = (int * int)

type bop =
  | Add of pos
  | Sub  of pos
  | Mult of pos
  | Div of pos
     
  | Concat of pos

  | Equal of pos
  | Nequal of pos
  | Less of pos
  | Lequal of pos
  | Grtr of pos
  | Grequal of pos

  | And of pos
  | Or of pos

  | Is of pos

  | Ind of pos
  | Dot of pos
  | DotDot of pos

type uop =
  | Neg of pos
  | Not of pos
  | Len of pos

type expr =
  | Nullit of pos
  | Boolit of pos * bool
  | Numlit of pos * float
  | Strlit of pos * string
  | Objlit of pos * (string * expr) list
  | Arrlit of pos * expr list
  | Id of pos * string
  | Unop of pos * expr * uop
  | Binop of pos * expr * bop * expr
  | Call of pos * string * expr list

type stmt =
  | Block of pos * stmt list
  | Assign of pos * string * string option * expr option * expr
  | Break of pos
  | Continue of pos
  | If of pos * expr * stmt
  | IfElse of pos * expr * stmt * stmt
  | While of pos * expr * stmt
  | Return of pos * expr option

type func = {
  pos: pos;
  name: string;
  args: string list;
  body: stmt list;
}

type program = {
  funcs: func list;
}

