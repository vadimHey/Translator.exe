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

"int"           { return INT; }
"double"        { return DOUBLE; }
"float"         { return FLOAT; }
"string"        { return STRING; }
"bool"          { return BOOL; }
"void"          { return VOID; }

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
{DIGIT}+\.{DIGIT}+  { yylval.str = strdup(yytext); return FLOATVAL; }
\"([^\\\"]|\\.)*\" { yylval.str = strdup(yytext); return STRINGVAL; }
{ID}            { yylval.str = strdup(yytext); return IDENTIFIER; }

{WS}            { /* игнорирование пробелов, табов */ }
{NEWLINE}       { /* игнорирование переноса строк */ }
{COMMENT}       { /* игноривание комментариев */ }

%%