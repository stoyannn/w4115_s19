{
  open Parser
}

let digit = ['0'-'9'] in
let letter = ['a'-'z' 'A'-'Z'] in
let whitespace = [' ' '\t' '\011' '\012'] in
let newline = '\r' | '\n' | "\r\n" in

rule token = parse
  | whitespace { token lexbuf }
  | newline    { token lexbuf }

  | "//" { token_comment lexbuf }
  | ';'  { SEMI }
  | ':'  { COLON }
  | ','  { COMMA }
  | '?'  { QUEST }
  | '('  { LPAREN }
  | ')'  { RPAREN }
  | '{'  { LBRACE }
  | '}'  { RBRACE }
  | '['  { LBRACK }
  | ']'  { RBRACK }
  | '='  { ASSIGN }
  | '*'  { MULT }
  | '/'  { DIV }
  | '+'  { PLUS }
  | '-'  { MINUS }
  | '<'  { LT }
  | "<=" { LEQ }
  | '>'  { GT }
  | ">=" { GEQ }
  | "==" { EQ }
  | "!=" { NEQ }
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

  | "null"  { NULLIT }
  | "true"  { BOOLIT(true) }
  | "false" { BOOLIT(false) }
  | (digit)+ (. (digit)+)? as num { NUMLIT(float_of_string num) }
  | '"' { token_string (Buffer.create 10) lexbuf }
  | (letter|underscore) (letter|digit|underscore)* as id { ID(id) }

  | eof { EOF }
  | _ as chr { raise (Failure("Illegal character " ^ Char.escaped chr)) }

and token_comment = parse
  | newline { token lexbuf }
  | _ { token_comment lexbuf }

and token_string str = parse
  | '"'           { STRLIT (Buffer.contents buf) }
  | "\\\""        { Buffer.add_char str '"'; token_string str lexbuf }
  | "\\\\"        { Buffer.add_char str '\\'; token_string str lexbuf }
  | "\\b"         { Buffer.add_char str '\b'; token_string str lexbuf }
  | "\\n"         { Buffer.add_char str '\n'; token_string str lexbuf }
  | "\\r"         { Buffer.add_char str '\r'; token_string str lexbuf }
  | "\\t"         { Buffer.add_char str '\t'; token_string str lexbuf }
  | [^ '"' '\\']+ { Buffer.add_string str (Lexing.lexeme lexbuf); token_string str lexbuf }
  | eof           { raise (Failure ("String literal not terminated")) }
  | _ as chr      { raise (Failure ("Illegal character " ^ Char.escaped chr)) }
 
