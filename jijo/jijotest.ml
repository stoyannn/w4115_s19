open Lexing

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

let parse_buf lexbuf =
  try
    let program = Jijoparse.program Jijoscan.token lexbuf
    in
    let sprogram = Jijosemant.sprogram_of_program program
    in
    Ok (Jijohelp.str_of_sprogram sprogram)
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
  let lexbuf = Lexing.from_channel stdin in
  match (parse_buf lexbuf) with
  | Ok res -> print_endline res;
  | Error (ln, ch, func, msg) -> prerr_endline (str_of_error ln ch func msg)
