open Ast
open Sast

let rec sexpr_of_expr = function
  | Nullit x -> (Null, SNullit)
  | Boolit x -> (Bool, SBoolit x)
  | Numlit x -> (Number, Snumlit x)
  | Strlit x -> (String, SStrlit x)
  | Objlit x -> (Object, SObjlit x)
  | Arrlit x -> (Array, SArrlit x)
  | Id x -> sexpr_of_id x
  | Unop(e, o) ->
    let (t, e') = sexpr_of_expr e
    and t' = match o with
      | Neg when t = Void || t = Number -> Number
      | Not when t = Void || t = Bool -> Bool
      | Len when t = Void || t = String || t = Array -> Number
      | _ -> raise (Failure "Unop type error")
    in
    (t', SUnop(e', o))
  | Binop(e1, o, e2) as e ->
    let (t1, e1') = sexpr_of_expr e1
    and let (t2, e2') = sexpr_of_expr e2
    in

    

  | Assign(bling s, e)

  | Call(f, a)
