(*
 * JIJO SAST nodes.
 *)

open Jijoast

type typ =
  | Null | Bool | Number | String | Object | Array

type sexpr = typ option * sx
and sx =
  | SNullit of pos
  | SBoolit of pos * bool
  | SNumlit of pos * float
  | SStrlit of pos * string
  | SObjlit of pos * (string * sexpr) list
  | SArrlit of pos * sexpr list
  | SId of pos * string
  | SUnop of pos * sexpr * uop
  | SBinop of pos * sexpr * bop * sexpr
  | SAssign of pos * string * sexpr
  | SCall of pos * string * sexpr list

type sstmt =
  | SBlock of pos * sstmt list
  | SExpr of pos * sexpr
  | SBreak of pos
  | SContinue of pos
  | SIf of pos * sexpr * sstmt
  | SIfElse of pos * sexpr * sstmt * sstmt
  | SWhile of pos * sexpr * sstmt
  | SReturn of pos * sexpr option

type sfunc = {
  spos: pos;
  sname: string;
  sargs: string list;
  sbody: sstmt list;
}

type sprogram = {
  sfuncs: sfunc list;
}

