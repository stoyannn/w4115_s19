(*
 * JIJO scanner rules.
 *)

{
  open Lexing
  open Jijoparse

  (* (line, char), message *)
  exception SyntaxError of (int * int) * string

  (* gets current (line, char) position in lexbuf *)
  let pos lexbuf =
    let p = lexbuf.lex_curr_p
    in
    (p.pos_lnum, p.pos_cnum - p.pos_bol + 1)
}

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']
let whitespace = [' ' '\t' '\011' '\012']
let newline = '\r' | '\n' | "\r\n"

rule token = parse
  | newline    { Lexing.new_line lexbuf; token lexbuf }
  | whitespace { token lexbuf }

  | "//" { token_linecomment lexbuf }
  | "/*" { token_blockcomment lexbuf }

  | ';' { SEMI (pos lexbuf) }
  | ':' { COLON (pos lexbuf) }
  | ',' { COMMA (pos lexbuf) }
  | '?' { QUEST (pos lexbuf) }
  | '!' { EXCL (pos lexbuf) }

  | '(' { LPAREN (pos lexbuf) }
  | ')' { RPAREN (pos lexbuf) }
  | '{' { LBRACE (pos lexbuf) }
  | '}' { RBRACE (pos lexbuf) }
  | '[' { LBRACK (pos lexbuf) }
  | ']' { RBRACK (pos lexbuf) }

  | '+' { PLUS (pos lexbuf) }
  | '-' { MINUS (pos lexbuf) }
  | '*' { MULT (pos lexbuf) }
  | '/' { DIV (pos lexbuf) }

  | '^' { CONCAT (pos lexbuf) }

  | '=' { ASSIGN (pos lexbuf) }

  | "==" { EQ (pos lexbuf) }
  | "!=" { NEQ (pos lexbuf) }
  | '<'  { LT (pos lexbuf) }
  | "<=" { LEQ (pos lexbuf) }
  | '>'  { GT (pos lexbuf) }
  | ">=" { GEQ (pos lexbuf) }

  | "&&" { AND (pos lexbuf) }
  | "||" { OR (pos lexbuf) }

  | '.'  { DOT (pos lexbuf) }
  | ".." { DOTDOT (pos lexbuf) }

  | "break"    { BREAK (pos lexbuf) }
  | "continue" { CONTINUE (pos lexbuf) }
  | "else"     { ELSE (pos lexbuf) }
  | "if"       { IF (pos lexbuf) }
  | "is"       { IS (pos lexbuf) }
  | "return"   { RETURN (pos lexbuf) }
  | "while"    { WHILE (pos lexbuf) }

  | "null"                          { NULLIT (pos lexbuf) }
  | "true"                          { BOOLIT ((pos lexbuf), true) }
  | "false"                         { BOOLIT ((pos lexbuf), false) }
  | (digit)+ ('.' (digit)+)? as num { NUMLIT ((pos lexbuf), float_of_string num) }
  | '"'                             { token_string (Buffer.create 16) lexbuf }

  | (letter|'_') (letter|digit|'_')* as id { ID ((pos lexbuf), id) }

  | eof      { EOF (pos lexbuf) }
  | _ as chr { raise (SyntaxError (pos lexbuf, "Illegal character: " ^ Char.escaped chr)) }

and token_linecomment = parse
  | newline { Lexing.new_line lexbuf; token lexbuf }
  | _       { token_linecomment lexbuf }

and token_blockcomment = parse
  | newline { Lexing.new_line lexbuf; token_blockcomment lexbuf }
  | "*/"    { token lexbuf }
  | _       { token_blockcomment lexbuf }

and token_string str = parse
  | newline       { Lexing.new_line lexbuf; token_string str lexbuf }
  | '"'           { STRLIT ((pos lexbuf), Buffer.contents str) }
  | "\\\""        { Buffer.add_char str '"'; token_string str lexbuf }
  | "\\\\"        { Buffer.add_char str '\\'; token_string str lexbuf }
  | "\\b"         { Buffer.add_char str '\b'; token_string str lexbuf }
  | "\\n"         { Buffer.add_char str '\n'; token_string str lexbuf }
  | "\\r"         { Buffer.add_char str '\r'; token_string str lexbuf }
  | "\\t"         { Buffer.add_char str '\t'; token_string str lexbuf }
  | [^ '"' '\\']+ { Buffer.add_string str (Lexing.lexeme lexbuf); token_string str lexbuf }
  | eof           { raise (SyntaxError (pos lexbuf, "String literal not terminated")) }
  | _ as chr      { raise (SyntaxError (pos lexbuf, "Illegal character: " ^ Char.escaped chr)) }

