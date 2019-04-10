%{
  open Ast
%}

%token SEMI COLON COMMA QUEST
%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK
%token ASSIGN
%token MULT DIV PLUS MINUS
%token LT LEQ GT GEQ EQ NEQ
%token AND OR
%token DOT DOTDOT

%token BREAK CONTINUE ELSE IF IS NULL RETURN WHILE

%token <bool> BOOLIT
%token <float> NUMLIT
%token <string> STRLIT
%token <string> ID
%token EOF

%start program
%type <Ast.program> program

%%

program:
  | func_list EOF { {funcs=$1} }

func_list:
  | { [] }
  | func func_list { $1 :: $2 }

func:
  | ID LPAREN RPAREN LBRACE stmt_list RBRACE { {$1, $5} }

stmt_list:
  | { [] }
  | stmt stmt_list { $1 :: $2 }

stmt:
  | expr SEMI { Expr $1 }
  | LBRACE stmt_list RBRACE { Block $2 }
  | IF LPAREN expr RPAREN stmt ELSE stmt { If ($3, $5, $7) }
  | WHILE LPAREN expr RPAREN stmt { While ($3, $5) }

expr:
  | BOOLIT { Boolit($1) }
  | NUMLIT { Numlit($1) }
  | STRLIT { Strlit($1) }
  | ID { Id($1) }

