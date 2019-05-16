open Lexing
open Printf

type action = Ast | Sast | Llvmir

type result =
  | Ok of string
  | Error of int * int * string option * string

let str_of_error ln ch func msg =
  let trail = match func with
    | Some(x) -> ", function '" ^ x ^ "':\n"
    | None -> ":\n"
  in
  "Line " ^ (string_of_int ln) ^ ", character " ^ (string_of_int ch) ^ trail ^
  "Error: " ^ msg

let parse_buf lexbuf action =
  try
    match action with
    | Ast ->
      Ok (Jijohelp.str_of_program
           (Jijoparse.program Jijoscan.token lexbuf))
    | Sast ->
      Ok (Jijohelp.str_of_sprogram
           (Jijosemant.sprogram_of_program
             (Jijoparse.program Jijoscan.token lexbuf)))
    | Llvmir ->
      Ok (Llvm.string_of_llmodule
           (Jijoirgen.llmodule_of_sprogram
             (Jijosemant.sprogram_of_program
               (Jijoparse.program Jijoscan.token lexbuf))))
  with
  | Jijoscan.SyntaxError ((ln, ch), msg) ->
    Error (ln, ch, None, msg)
  | Parsing.Parse_error ->
    let p = lexbuf.lex_curr_p
    in
    Error (p.pos_lnum, p.pos_cnum - p.pos_bol, None, "Syntax error")
  | Jijosemant.SemantError ((ln, ch), func, msg) ->
    Error (ln, ch, func, msg)

let _ =
  let action = ref Llvmir
  in
  let set_action a () = action := a
  in
  let speclist =
    [
      ("-a", Arg.Unit (set_action Ast), "Print the AST");
      ("-s", Arg.Unit (set_action Sast), "Print the SAST");
      ("-l", Arg.Unit (set_action Llvmir), "Print the LLVM IR");
    ]
  in

  let usage_msg = "usage: ./jijo.native [-a|-s|-l] [in_file.jj] [out_file.ll]"
  in
  let inc = ref stdin
  in
  let outc = ref stdout
  in
  let errc = ref stderr
  in
  let open_file f =
    if !inc = stdin then
      inc := open_in f
    else
      outc := open_out f
  in
  Arg.parse speclist (open_file) usage_msg;

  let lexbuf = Lexing.from_channel !inc
  in

  match (parse_buf lexbuf !action) with
  | Ok res -> fprintf !outc "%s\n" res;
  | Error (ln, ch, func, msg) -> fprintf !errc "%s\n" (str_of_error ln ch func msg)

