/*
 * JIJO parser rules.
 */

%{
  open Jijoast
%}

%token <int * int> SEMI
%token <int * int> COLON
%token <int * int> COMMA
%token <int * int> QUEST
%token <int * int> EXCL

%token <int * int> LPAREN
%token <int * int> RPAREN
%token <int * int> LBRACE
%token <int * int> RBRACE
%token <int * int> LBRACK
%token <int * int> RBRACK

%token <int * int> PLUS
%token <int * int> MINUS
%token <int * int> MULT
%token <int * int> DIV
%token <int * int> CONCAT

%token <int * int> ASSIGN

%token <int * int> EQ
%token <int * int> NEQ
%token <int * int> LT
%token <int * int> LEQ
%token <int * int> GT
%token <int * int> GEQ

%token <int * int> AND
%token <int * int> OR

%token <int * int> DOT
%token <int * int> DOTDOT

%token <int * int> BREAK
%token <int * int> CONTINUE
%token <int * int> ELSE
%token <int * int> IF
%token <int * int> IS 
%token <int * int> RETURN
%token <int * int> WHILE

%token <int * int> NULLIT
%token <(int * int) * bool> BOOLIT
%token <(int * int) * float> NUMLIT
%token <(int * int) * string> STRLIT

%token <(int * int) * string> ID

%token <int * int> EOF

%start program
%type <Jijoast.program> program

%right ASSIGN
%right IS
%left OR
%left AND
%left EQ NEQ
%left LT LEQ GT GEQ
%left CONCAT
%left PLUS MINUS
%left MULT DIV
%left DOT
%left DOTDOT
%left LBRACK
%nonassoc UMINUS
%right EXCL

%%

program:
  | func_list EOF { {funcs=$1} }

func_list:
  | { [] }
  | func func_list { $1 :: $2 }

func:
  | ID LPAREN id_opt RPAREN ASSIGN LBRACE stmt_list RBRACE
    {{ pos = fst $1; name = snd $1; args = $3; body = $7}}

stmt_list:
  | { [] }
  | stmt stmt_list { $1 :: $2 }

/*
 * NOTE for stmt rule below:
 * 1) shift/reduce conflict for:
 *     a) IF LPAREN expr RPAREN stmt
 *     b) IF LPAREN expr RPAREN stmt ELSE stmt
 *   Default YACC resolution to prefer shift will match ELSE w/ closest IF
 * 2) reduce/reduce conflict for:
 *     a) LBRACE stmt_list RBRACE
 *     b) expr SEMI (where expr can be LBRACE field_opt RBRACE)
 *   Default YACC resolution to reduce first rule will use curly braces as stmt_list delimiter
 */
stmt:
  | LBRACE stmt_list RBRACE { Block ($1, $2) }
  | BREAK SEMI { Break $1 }
  | CONTINUE SEMI { Continue $1 }
  | IF LPAREN expr RPAREN stmt { If ($1, $3, $5) }
  | IF LPAREN expr RPAREN stmt ELSE stmt { IfElse ($1, $3, $5, $7) }
  | WHILE LPAREN expr RPAREN stmt { While ($1, $3, $5) }
  | RETURN expr SEMI { Return ($1, Some $2) }
  | RETURN SEMI { Return ($1, None) }
  | expr SEMI { Expr ($2, $1) }

expr:
  | NULLIT { Nullit $1 }
  | BOOLIT { Boolit (fst $1, snd $1) }
  | NUMLIT { Numlit (fst $1, snd $1) }
  | STRLIT { Strlit (fst $1, snd $1) }
  | LBRACE field_opt RBRACE { Objlit ($1, $2) }
  | LBRACK expr_opt RBRACK { Arrlit ($1, $2) }
  | ID { Id (fst $1, snd $1) }
  | LPAREN expr RPAREN { $2 }

  | MINUS expr %prec UMINUS { Unop ($1, $2, Neg $1) }
  | EXCL expr { Unop ($1, $2, Not $1) }
  | expr LBRACK QUEST RBRACK { Unop ($3, $1, Len $3) }

  | expr PLUS expr { Binop ($2, $1, Add $2, $3) }
  | expr MINUS expr { Binop ($2, $1, Sub $2, $3) }
  | expr MULT expr { Binop ($2, $1, Mult $2, $3) }
  | expr DIV expr { Binop ($2, $1, Div $2, $3) }
  | expr CONCAT expr { Binop ($2, $1, Concat $2, $3) }
  | expr EQ expr { Binop ($2, $1, Equal $2, $3) }
  | expr NEQ expr { Binop ($2, $1, Nequal $2, $3) }
  | expr LT expr { Binop ($2, $1, Less $2, $3) }
  | expr LEQ expr { Binop ($2, $1, Lequal $2, $3) }
  | expr GT expr { Binop ($2, $1, Grtr $2, $3) }
  | expr GEQ expr { Binop ($2, $1, Grequal $2, $3) }
  | expr AND expr { Binop ($2, $1, And $2, $3) }
  | expr OR expr { Binop ($2, $1, Or $2, $3) }
  | expr IS expr { Binop ($2, $1, Is $2, $3) }
  | expr LBRACK expr RBRACK { Binop ($2, $1, Ind $2, $3) }
  | expr DOT expr { Binop ($2, $1, Dot $2, $3) }
  | expr DOTDOT expr { Binop ($2, $1, DotDot $2, $3) }

  | ID ASSIGN expr { Assign (fst $1, snd $1, $3) }
  | ID LPAREN expr_opt RPAREN { Call(fst $1, snd $1, $3) }

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
  | ID { [snd $1] }
  | ID COMMA id_list { snd $1 :: $3 }

field_opt:
  | { [] }
  | field_list { $1 }

field_list:
  | field { [$1] }
  | field COMMA field_list { $1 :: $3 }

field:
  | ID COLON expr { (snd $1, $3) }

