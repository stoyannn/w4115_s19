{
  open Lexing
  open Jijoparse

  exception SyntaxError of string
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

  | ';' { SEMI }
  | ':' { COLON }
  | ',' { COMMA }
  | '?' { QUEST }

  | '(' { LPAREN }
  | ')' { RPAREN }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | '[' { LBRACK }
  | ']' { RBRACK }

  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { MULT }
  | '/' { DIV }

  | '=' { ASSIGN }

  | "==" { EQ }
  | "!=" { NEQ }
  | '<'  { LT }
  | "<=" { LEQ }
  | '>'  { GT }
  | ">=" { GEQ }

  | "&&" { AND }
  | "||" { OR }

  | '.'  { DOT }
  | ".." { DOTDOT }

  | "break"    { BREAK }
  | "continue" { CONTINUE }
  | "else"     { ELSE }
  | "if"       { IF }
  | "is"       { IS }
  | "return"   { RETURN }
  | "while"    { WHILE }

  | "null"                        { NULLIT }
  | "true"                        { BOOLIT(true) }
  | "false"                       { BOOLIT(false) }
  | (digit)+ ('.' (digit)+)? as num { NUMLIT(float_of_string num) }
  | '"'                           { token_string (Buffer.create 16) lexbuf }

  | (letter|'_') (letter|digit|'_')* as id { ID(id) }

  | eof      { EOF }
  | _ as chr { raise (SyntaxError("Illegal character: " ^ Char.escaped chr)) }

and token_linecomment = parse
  | newline { Lexing.new_line lexbuf; token lexbuf }
  | _       { token_linecomment lexbuf }

and token_blockcomment = parse
  | newline { Lexing.new_line lexbuf; token_blockcomment lexbuf }
  | "*/"    { token lexbuf }
  | _       { token_blockcomment lexbuf }

and token_string str = parse
  | newline       { Lexing.new_line lexbuf; token_string str lexbuf }
  | '"'           { STRLIT (Buffer.contents str) }
  | "\\\""        { Buffer.add_char str '"'; token_string str lexbuf }
  | "\\\\"        { Buffer.add_char str '\\'; token_string str lexbuf }
  | "\\b"         { Buffer.add_char str '\b'; token_string str lexbuf }
  | "\\n"         { Buffer.add_char str '\n'; token_string str lexbuf }
  | "\\r"         { Buffer.add_char str '\r'; token_string str lexbuf }
  | "\\t"         { Buffer.add_char str '\t'; token_string str lexbuf }
  | [^ '"' '\\']+ { Buffer.add_string str (Lexing.lexeme lexbuf); token_string str lexbuf }
  | eof           { raise (SyntaxError ("String literal not terminated")) }
  | _ as chr      { raise (SyntaxError ("Illegal character " ^ Char.escaped chr)) }

