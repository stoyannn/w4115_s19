open Jijoast

type typ =
  | Void | Null | Bool | Number | String | Object | Array

type sexpr = typ option * sx
and sx =
  | SNullit
  | SBoolit of bool
  | SNumlit of float
  | SStrlit of string
  | SObjlit of (string * sexpr) list
  | SArrlit of sexpr list
  | SId of string
  | SUnop of sexpr * uop
  | SBinop of sexpr * bop * sexpr
  | SAssign of string * sexpr
  | SCall of string * sexpr list

type sstmt =
  | SBlock of sstmt list
  | SExpr of sexpr
  | SBreak
  | SContinue
  | SIf of sexpr * sstmt
  | SIfElse of sexpr * sstmt * sstmt
  | SWhile of sexpr * sstmt
  | SReturn of sexpr option

type sfunc = {
  sname: string;
  sargs: string list;
  sbody: sstmt list;
}

type sprogram = {
  sfuncs: sfunc list;
}

