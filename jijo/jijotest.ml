open Lexing

type ('a, 'b) result =
  | Ok of 'a
  | Error of 'b

let str_of_pos_and_msg ln ch msg =
  "Line " ^ (string_of_int ln) ^ ", character " ^ (string_of_int ch) ^ ": " ^ msg

let parse_buf lexbuf =
  try
    let program = Jijoparse.program Jijoscan.token lexbuf
    in
    let sprogram = Jijosemant.sprogram_of_program program
    in
    Ok (Jijohelp.str_of_sprogram sprogram)
  with
  | Jijoscan.SyntaxError ((ln, ch), msg) ->
    Error (ln, ch, msg)
  | Parsing.Parse_error ->
    Error (0, 0, "syntax error")

let _ =
  let lexbuf = Lexing.from_channel stdin in
  match (parse_buf lexbuf) with
  | Ok res -> print_endline res;
  | Error (ln, ch, msg) -> prerr_endline (str_of_pos_and_msg ln ch msg)
