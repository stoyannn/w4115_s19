open Lexing

type ('a, 'b) result =
  | Ok of 'a
  | Error of 'b

let str_of_pos_and_msg pos msg =
  "Line " ^ (string_of_int pos.pos_lnum)
  ^ ", character " ^ (string_of_int (pos.pos_cnum - pos.pos_bol + 1))
  ^ ": " ^ msg

let parse_buf lexbuf =
  try
    let program = Jijoparse.program Jijoscan.token lexbuf
    in
    let sprogram = Jijosemant.sprogram_of_program program
    in
    Ok (Jijohelp.str_of_sprogram sprogram)
  with
  | Jijoscan.SyntaxError msg ->
    Error (lexbuf.lex_curr_p, msg)
  | Parsing.Parse_error ->
    Error (lexbuf.lex_curr_p, "syntax error")

let _ =
  let lexbuf = Lexing.from_channel stdin in
  match (parse_buf lexbuf) with
  | Ok res -> print_endline res;
  | Error (pos, msg) -> prerr_endline (str_of_pos_and_msg pos msg)
