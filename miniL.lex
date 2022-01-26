           /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
	#include <stdlib.h>
	
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

"function"	{ yylval.keyword = yytext; return FUNCTION; }
"beginparams" 	{ yylval.keyword = yytext; return BEGIN_PARAMS; }
"endparams"   	{ yylval.keyword = yytext; return END_PARAMS; }
"beginlocals" 	{ yylval.keyword = yytext; return BEGIN_LOCALS; }
"endlocals"   	{ yylval.keyword = yytext; return END_LOCALS; }
"beginbody"   	{ yylval.keyword = yytext; return BEGIN_BODY; }
"endbody"     	{ yylval.keyword = yytext; return END_BODY; }
"integer"     	{ yylval.keyword = yytext; return INTEGER; }
"array"       	{ yylval.keyword = yytext; return ARRAY; }
"of"          	{ yylval.keyword = yytext; return OF; }
"if"          	{ yylval.keyword = yytext; return IF; }
"then"        	{ yylval.keyword = yytext; return THEN; }
"endif"       	{ yylval.keyword = yytext; return ENDIF; }
"else"        	{ yylval.keyword = yytext; return ELSE; }
"while"       	{ yylval.keyword = yytext; return WHILE; }
"do"          	{ yylval.keyword = yytext; return DO; }
"for"         	{ yylval.keyword = yytext; return FOR; }
"beginloop"   	{ yylval.keyword = yytext; return BEGINLOOP; }
"endloop"     	{ yylval.keyword = yytext; return ENDLOOP; }
"continue"    	{ yylval.keyword = yytext; return CONTINUE; }
"read"        	{ yylval.keyword = yytext; return READ; }
"write"       	{ yylval.keyword = yytext; return WRITE; }
"and"         	{ yylval.keyword = yytext; return AND; }
"or"          	{ yylval.keyword = yytext; return OR; }
"not"         	{ yylval.keyword = yytext; return NOT; }
"true"        	{ yylval.keyword = yytext; return TRUE; }
"false"       	{ yylval.keyword = yytext; return FALSE; }
"return"      	{ yylval.keyword = yytext; return RETURN}
";"		{ yylval.symbol = yytext; return SEMICOLON; }
{colon}		{ yylval.symbol = yytext; return COLON; }
","		{ yylval.symbol = yytext; return COMMA; }
"("		{ yylval.symbol = yytext; return L_PAREN; }
")"		{ yylval.symbol = yytext; return R_PAREN; }
"["		{ yylval.symbol = yytext; return L_SQUARE_BRACKET; }
"]"		{ yylval.symbol = yytext; return R_SQUARE_BRACKET; }
{ASSIGN}	{ yylval.symbol = yytext; return ASSIGN; }
{SUB}		{ yylval.aop = yytext; return SUB; }
{ADD}		{ yylval.aop = yytext; return ADD; }
{MULT}		{ yylval.aop = yytext; return MULT; }
{DIV}		{ yylval.aop = yytext; return DIV; }
{MOD}		{ yylval.aop = yytext; return MOD; }
{EQ}		{ yylval.cop = yytext; return EQ; }
{NEQ}		{ yylval.cop = yytext; return NEQ; }
{LT}		{ yylval.cop = yytext; return LT; }
{GT}		{ yylval.cop = yytext; return GT; }
{LTE}		{ yylval.cop = yytext; return LTE;}
{GTE}		{ yylval.cop = yytext; return GTE; }
{comment}	{}
{IDENT}		{ yylval.id = yytext; return IDENT; }
{NUMBER}	{ yylval.num = atoi(yytext); return NUMBER; }
{newline}	{line++; col = 0;}
{whitespace}	{col++;}
{ERROR1}	{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", line, col, yytext); exit(1);}
{ERROR2}	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, col, yytext); exit(1);}
{ERROR3}	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with underscore\n", line, col, yytext); exit(1);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
