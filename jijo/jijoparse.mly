%{
  open Jijoast
%}

%token SEMI COLON COMMA QUEST
%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK
%token PLUS MINUS MULT DIV
%token ASSIGN
%token EQ NEQ LT LEQ GT GEQ
%token AND OR
%token DOT DOTDOT

%token BREAK CONTINUE ELSE IF IS RETURN WHILE

%token <bool> BOOLIT
%token <float> NUMLIT
%token <string> STRLIT
%token NULLIT

%token <string> ID

%token EOF

%start program
%type <Jijoast.program> program

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT LEQ GT GEQ
%left PLUS MINUS
%left MULT DIV
%left DOT
%left DOTDOT

%%

program:
  | func_list EOF { {funcs=$1} }

func_list:
  | { [] }
  | func func_list { $1 :: $2 }

func:
  | ID LPAREN id_opt RPAREN LBRACE stmt_list RBRACE { {$1, $3, $6} }

stmt_list:
  | { [] }
  | stmt stmt_list { $1 :: $2 }

stmt:
  | expr SEMI { Expr $1 }
  | LBRACE stmt_list RBRACE { Block $2 }
  | BREAK SEMI { Break }
  | CONTINUE SEMI { Continue }
  | IF LPAREN expr RPAREN stmt ELSE stmt { If ($3, $5, $7) }
  | WHILE LPAREN expr RPAREN stmt { While ($3, $5) }
  | RETURN expr SEMI { Return (Some $2) }
  | RETURN SEMI { Return None }

expr:
  | BOOLIT { Boolit($1) }
  | NUMLIT { Numlit($1) }
  | STRLIT { Strlit($1) }
  | NULLIT { Nullit }
  | LBRACE field_opt RBRACE { Objlit($2) }
  | LBRACK expr_opt RBRACK { Arrlit($2) }
  | ID { Id($1) }
  | ID ASSIGN expr { Assign($1, $3) }
  | RETURN expr SEMI { Return $2 }

  | expr PLUS expr { Binop($1, Add, $3) }
  | expr MINUS expr { Binop($1, Sub, $3) }
  | expr MULT expr { Binop($1, Mult, $3) }
  | expr DIV expr { Binop($1, Div, $3) }
  | expr EQ expr { Binop($1, Equal, $3) }
  | expr NEQ expr { Binop($1, Nequal, $3) }
  | expr LT expr { Binop($1, Less, $3) }
  | expr LEQ expr { Binop($1, Lequal, $3) }
  | expr GT expr { Binop($1, Grtr, $3) }
  | expr GEQ expr { Binop($1, Grequal, $3) }
  | expr AND expr { Binop($1, And, $3) }
  | expr OR expr { Binop($1, Or, $3) }
  | expr IS expr { Binop($1, Is, $3) }
  | expr DOT expr { Binop($1, Dot, $3) }
  | expr DOTDOT expr { Binop($1, Dotdot, $3) }

  | LPAREN expr RPAREN { $2 }
  | ID LPAREN expr_opt RPAREN { Call ($1, $3) }

expr_opt:
  | { [] }
  | expr_list { $1 }

expr_list:
  | expr { [$1] }
  | expr COMMA expr_list { $1 :: $3 }

id_opt:
  | { [] }
  | id_list { $1 }

id_list:
  | ID { [Id($1)] }
  | ID COMMA id_list { Id($1) :: $3 }

field:
  | ID COLON expr { ($1, $3) }

field_opt:
  | { [] }
  | field_list { $1 }

field_list:
  | field { [$1] }
  | field COMMA field_list { $1 :: $3 }
