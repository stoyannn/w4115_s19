(*
 * JIJO LLVM IR generator.
 *)

open Llvm
open Jijosast

module L = Llvm
module A = Jijoast
module StringMap = Map.Make(String)


(* LLVM IR generation context *)
type context = {
  c: L.llcontext;
  m: L.llmodule;
  i8_t: lltype; 
  double_t: lltype;
  val_t: lltype;
  funtab: (L.llvalue * sfunc) StringMap.t;
}


let llmodule_of_sprogram sprogram =


let cont =
  let c = L.global_context ();
  in
  let m = L.create_module c "Jijo";
  and i8_t = L.i8_type c
  and double_t = L.double_type c
  in
  let val_t = L.struct_type c [| i8_t; double_t |]
  in
  let add_sfunc map f =
    let args_t = Array.of_list (List.map (fun _ -> val_t) f.sargs)
    in
    let func_t = L.function_type val_t args_t
    in
    StringMap.add f.sname (L.define_function f.sname func_t m, f) map
  in
  {
    c = c;
    m = m;
    i8_t = i8_t;
    double_t = double_t;
    val_t = val_t;
    funtab = List.fold_left add_sfunc StringMap.empty sprogram.sfuncs;
  }
in


(* runtime constants *)
let const_void    = L.const_int cont.i8_t 0
and const_null    = L.const_int cont.i8_t 1
and const_boolean = L.const_int cont.i8_t 2
and const_number  = L.const_int cont.i8_t 3
and const_string  = L.const_int cont.i8_t 4
and const_object  = L.const_int cont.i8_t 5
and const_array   = L.const_int cont.i8_t 6
and const_true    = L.const_float cont.double_t 1.0
and const_false   = L.const_float cont.double_t 0.0
in


let build_sfunc sfunc =
  ()
in


List.iter build_sfunc sprogram.sfuncs;
cont.m

