    /* cs152-miniL phase2 */
%{
#include<stdio.h>
#include<stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char *msg);
%}

%union{
  /* put your types here */
	int num;
	char* id;
		
}

%error-verbose
%locations

/* %start program */
%start Program
%token<id> IDENT
%token<num> NUMBER
%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token BREAK
%token READ
%token WRITE
%token NOT
%token TRUE
%token FALSE
%token RETURN
%token SUB
%token ADD
%token MULT
%token DIV
%token MOD
%token EQ
%token NEQ
%token LT
%token GT
%token LTE
%token GTE
%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token ASSIGN

%% 

  /* write your rules here */
Program:	Functions Program { printf("prog_start -> function\n"); }
		| /* empty */ { printf("prog_start -> epsilon\n"); }
		;

Functions:	FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declaration END_PARAMS BEGIN_LOCALS Declaration END_LOCALS BEGIN_BODY Statement END_BODY
		{ printf("functions -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declaration END_PARAMS BEGIN_LOCALS Declaration END_LOCALS BEGIN_BODY Statement END_BODY\n");}
		| Functions Functions { printf("functions -> functions functions\n"); }
		| /* empty */ { printf("functions -> epsilon/n"); }
		;

Declaration: 	IDENT COLON INTEGER { printf("Declaration -> IDENT COLON INTEGER"); }
		| IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
		{ printf("Declaration -> IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n"); }
		| Declaration SEMICOLON Declaration { printf("Declaration -> Declaration SEMICOLON Declaration\n"); }
		| /* empty */ { printf("Declaration -> epsilon\n"); }
		;


Statement:	Statement SEMICOLON Statement { printf("Statement -> Statement SEMICOLON Statement\n"); }
		| Var ASSIGN Expression {printf("Statement -> Var ASSIGN Expression\n"); }
		| IF BoolExp THEN Statement ENDIF { printf("Statement -> IF BoolExp THEN Statement ENDIF\n"); }
		| IF BoolExp THEN Statement ELSE Statement ENDIF { printf("Statement -> IF BoolExp THEN Statement ELSE Statement ENDIF\n"); }
		| WHILE BoolExp BEGINLOOP Statement ENDLOOP { printf("Statement -> WHILE BoolExp BEGINLOOP Statement ENDLOOP\n"); }
		| DO BEGINLOOP Statement ENDLOOP WHILE BoolExp { printf("Statement -> DO BEGINLOOP Statement ENDLOOP WHILE BoolExp\n"); }
		| READ Var { printf("Statement -> READ Var\n"); }
		| WRITE Var { printf("Statement -> WRITE Var\n"); }
		| CONTINUE { printf("Statement -> CONTINUE\n"); }
		| RETURN Expression { printf("Statement -> RETURN Expression\n"); }
		| /* empty */ { printf("Statement -> epsilon\n"); }
		;

BoolExp: 	BoolExp BoolExp { printf("BoolExp -> BoolExp BoolExp\n"); }
		| Expression Comp Expression { printf("BoolExp -> Expression Comp Expression\n"); }
		| NOT { printf("BoolExp -> NOT\n"); }
		| /* empty */ { printf("BoolExp -> epsilon"); }
		;

Comp: 		EQ { printf("Comp -> EQ\n"); }
		| NEQ { printf("Comp -> NEQ\n"); }
		| LT { printf("Comp -> LT\n"); }
		| GT { printf("Comp -> GT\n"); }
		| LTE { printf("Comp -> LTE\n"); }
		| GTE { printf("Comp -> GTE\n"); }
		;

Expression: 	MultExp { printf("Expression -> MultExp\n"); }
		| MultExp ADD MultExp { printf("Expression -> MultExp PLUS MultExp\n"); }
		| MultExp SUB MultExp { printF("Expression -> MultExp SUB MultExp\n"); }
		;
MultExp: 	Term { printf("MultExp -> Term\n"); }
		| Term MULT Term { printf("MultExp -> Term MULT Term\n"); }
		| Term DIV Term { printf("MultExp -> Term DIV Term\n"); }
		| Term MOD Term { printf("MultExp -> Term MOD Term\n"); }
		;

Term: 		Var Term { printf("Term -> Var Term\n"); }
		| NUMBER { printf("Term -> NUMBER %d\n", $1); }
		| L_PAREN Expression Term R_PAREN { printf("Term -> L_PAREN EXPRESSINO Term R_PAREN\n"); }
		| COMMA Expression { printf("Term -> COMMA Expression\n"); }
		| /* empty */ { printf("Term -> epsilon\n"); }
		;

Var: 		Identifier Var { printf("Var -> Identifier Var\n"); }
		| L_SQUARE_BRACKET Expression  R_SQUARE_BRACKET { printf("Var -> L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n"); }
		| /* empty */ { printf("Var -> epsilon"); }
		;

Identifier: 	IDENT { printf("Identifier -> IDENT %S\n", $1); }; 
		
		
%% 

int main(int argc, char **argv) {
   yyin = stdin;
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
   printf("ERROR\n");
}














