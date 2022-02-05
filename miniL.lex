           /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
	#include <stdlib.h>
	#include <stdio.h>
	#include "y.tab.h"	
	int line = 1;
	int col = 0;	
%}

   /* some common rules */
DIGIT	[0-9]
ALPHA	[a-zA-Z]
NUMBER	{DIGIT}{DIGIT}*
colon	[:]
equal	[=]
ASSIGN	{colon}{equal}
SUB	[-]
ADD	[+]
MULT	[*]
DIV	[/]
MOD	[MOD]
EQ	{equal}{equal}
LT	[<]
GT	[>]
NEQ	{LT}{GT}
LTE	{LT}{equal}
GTE	{GT}{equal}
IDENT	{ALPHA}(({DIGIT}|{ALPHA}|"_")*({DIGIT}|{ALPHA}))?
pound	[#]
space	[" "]
tab	[\t]
newline	[\n]
comment {pound}{pound}({tab}|{space})*.*{newline}
whitespace	({newline}|{tab}|{space})
ERROR1	.		
ERROR2  {NUMBER}{IDENT}
ERROR3	{IDENT}"_"
%%
   /* specific lexer rules in regex */

"function"	{ return FUNCTION; }
"beginparams" 	{ return BEGIN_PARAMS; }
"endparams"   	{ return END_PARAMS; }
"beginlocals" 	{ return BEGIN_LOCALS; }
"endlocals"   	{ return END_LOCALS; }
"beginbody"   	{ return BEGIN_BODY; }
"endbody"     	{ return END_BODY; }
"integer"     	{ return INTEGER; }
"array"       	{ return ARRAY; }
"of"          	{ return OF; }
"if"          	{ return IF; }
"then"        	{ return THEN; }
"endif"       	{ return ENDIF; }
"else"        	{ return ELSE; }
"while"       	{ return WHILE; }
"do"          	{ return DO; }
"for"         	{ return FOR; }
"beginloop"   	{ return BEGINLOOP; }
"endloop"     	{ return ENDLOOP; }
"continue"    	{ return CONTINUE; }
"read"        	{ return READ; }
"write"       	{ return WRITE; }
"and"         	{ return AND; }
"or"          	{ return OR; }
"not"         	{ return NOT; }
"true"        	{ return TRUE; }
"false"       	{ return FALSE; }
"return"      	{ return RETURN; }
";"		{ return SEMICOLON; }
{colon}		{ return COLON; }
","		{ return COMMA; }
"("		{ return L_PAREN; }
")"		{ return R_PAREN; }
"["		{ return L_SQUARE_BRACKET; }
"]"		{ return R_SQUARE_BRACKET; }
{ASSIGN}	{ return ASSIGN; }
{SUB}		{ return SUB; }
{ADD}		{ return ADD; }
{MULT}		{ return MULT; }
{DIV}		{ return DIV; }
{MOD}		{ return MOD; }
{EQ}		{ return EQ; }
{NEQ}		{ return NEQ; }
{LT}		{ return LT; }
{GT}		{ return GT; }
{LTE}		{ return LTE;}
{GTE}		{ return GTE; }
{comment}	{}
{IDENT}		{ yylval.id = yytext; return IDENT; }
{NUMBER}	{ yylval.num = atoi(yytext); return NUMBER; }
{newline}	{line++; col = 0;}
{whitespace}	{col++;}
{ERROR1}	{yyerror("Unrecognized symbol");}
{ERROR2}	{yyerror("Syntax");}
{ERROR3}	{yyerror("Syntax");}
{equal}		{return equal;}

%%
	/* C functions used in lexer */

/*int main(int argc, char ** argv)
{
   yylex();
}*/
