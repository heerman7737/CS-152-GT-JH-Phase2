    /* cs152-miniL phase2 */
%{
void yyerror(const char *msg);
%}

%union{
  /* put your types here */
	int num;
	char* keyword;
	char* symbol;
	char* id;
	char* aop;
	char* cop;
		
}

%error-verbose
%locations

/* %start program */
%start input
%token<id> IDENT
%token<num> NUMBER
%token<keyword> FUNCTION
%token<keyword> BEGIN_PARAMS
%token<keyword> END_PARAMS
%token<keyword> BEGIN_LOCALS
%token<keyword> END_LOCALS
%token<keyword> BEGIN_BODY
%token<keyword> END_BODY
%token<keyword> INTEGER
%token<keyword> ARRAY
%token<keyword> OF
%token<keyword> IF
%token<keyword> THEN
%token<keyword> ENDIF
%token<keyword> ELSE
%token<keyword> WHILE
%token<keyword> DO
%token<keyword> BEGINLOOP
%token<keyword> ENDLOOP
%token<keyword> CONTINUE
%token<keyword> BREAK
%token<keyword> READ
%token<keyword> WRITE
%token<keyword> NOT
%token<keyword> TRUE
%token<keyword> FALSE
%token<keyword> RETURN
%token<aop> SUB
%token<aop> ADD
%token<aop> MULT
%token<aop> DIV
%token<aop> MOD
%token<cop> EQ
%token<cop> NEQ
%token<cop> LT
%token<cop> GT
%token<cop> LTE
%token<cop> GTE
%token<symbol> SEMICOLON
%token<symbol> COLON
%token<symbol> L_PAREN
%token<symbol> R_PAREN
%token<symbol> L_SQUARE_BRACKET
%token<symbol> R_SQUARE_BRACKET
%token<symbol> ASSIGN
%type program
%type function
%type declaration
%type statement
%type bool_exp
%type comp
%type exp
%type mult_exp
%type term
%type var

%% 

  /* write your rules here */
input:		/* empty */
		| program 
		;

program:

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}
