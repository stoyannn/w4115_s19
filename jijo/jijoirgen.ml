(*
 *
 *)

open Sast

module L = Llvm
module A = Ast
module StringMap = Map.Make(String)


let translate funcs =


  let context = L.global_context ()
  in

  let jijo_mod = L.create_module context "Jijo"
  in

  let i1_t = L.i1_type context
  and i8_t = L.i8_type context
  and double_t = L.double_type content
  in

  let ltyp_of_typ = function
     | A.Int   -> i32_t

                            | A.Bool  -> i1_t

                              in




