%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
%}

%option noyywrap
%option yylineno

DIGIT       [0-9]
ID          [a-zA-Z_][a-zA-Z0-9_]*
WS          [ \t]+
NEWLINE     (\r?\n)+
COMMENT     \/\/[^\n]*

%%

{COMMENT}       { /* ignore comments */ }

"int"           { yylval.str = strdup("int"); return INT; }
"double"        { yylval.str = strdup("float"); return DOUBLE; }
"float"         { yylval.str = strdup("float"); return FLOAT; }
"string"        { yylval.str = strdup("str"); return STRING; }
"bool"          { yylval.str = strdup("bool"); return BOOL; }
"void"          { yylval.str = strdup(""); return VOID; }

"if"            { return IF; }
"else"          { return ELSE; }
"for"           { return FOR; }
"while"         { return WHILE; }
"return"        { return RETURN; }
"print"         { return PRINT; }
"println"       { return PRINTLN; }
"List"          { return LIST; }
"new"           { return NEW; }

"true"          { yylval.str = strdup("True"); return BOOLVAL; }
"false"         { yylval.str = strdup("False"); return BOOLVAL; }

"=="            { return EQEQ; }
"!="            { return NEQ; }
"<="            { return LEQ; }
">="            { return GEQ; }

"<"             { return LT; }
">"             { return GT; }

"="             { return EQUAL; }
"+="            { return PLUSEQUAL; }
"-="            { return MINUSEQUAL; }
"++"            { return PLUSPLUS; }
"--"            { return MINUSMINUS; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }
"%"             { return MOD; }
"&&"            { return AND; }
"||"            { return OR; }

"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"["             { return LBRACKET; }
"]"             { return RBRACKET; }
"."             { return POINT; }
","             { return COMMA; }
";"             { return SEMICOLON; }

{DIGIT}+        { yylval.str = strdup(yytext); return NUMBER; }
[0-9]+\.[0-9]+  { yylval.str = strdup(yytext); return FLOATVAL; }

\"([^\\\"]|\\.)*\" { yylval.str = strdup(yytext); return STRINGVAL; }

{ID}            { yylval.str = strdup(yytext); return IDENTIFIER; }

{WS}            { /* ignore whitespace */ }
{NEWLINE}       { /* ignore newlines */ }

.               { 
                    fprintf(stderr, "Warning: ignoring unexpected character '%c' at line %d\n", yytext[0], yylineno); 
                }

%%

/* yywrap не нужен из-за %option noyywrap */