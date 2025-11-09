
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IDENTIFIER = 258,
     STRINGVAL = 259,
     NUMBER = 260,
     FLOATVAL = 261,
     BOOLVAL = 262,
     INT = 263,
     DOUBLE = 264,
     FLOAT = 265,
     STRING = 266,
     BOOL = 267,
     VOID = 268,
     IF = 269,
     ELSE = 270,
     FOR = 271,
     WHILE = 272,
     RETURN = 273,
     PRINT = 274,
     PRINTLN = 275,
     EQUAL = 276,
     PLUSEQUAL = 277,
     MINUSEQUAL = 278,
     PLUSPLUS = 279,
     MINUSMINUS = 280,
     PLUS = 281,
     MINUS = 282,
     MULTIPLY = 283,
     DIVIDE = 284,
     MOD = 285,
     LT = 286,
     GT = 287,
     LEQ = 288,
     GEQ = 289,
     EQEQ = 290,
     NEQ = 291,
     AND = 292,
     OR = 293,
     LBRACE = 294,
     RBRACE = 295,
     LPAREN = 296,
     RPAREN = 297,
     COMMA = 298,
     SEMICOLON = 299,
     LIST = 300,
     NEW = 301,
     LBRACKET = 302,
     RBRACKET = 303,
     POINT = 304
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 71 "parser.y"

    char *str;



/* Line 1676 of yacc.c  */
#line 107 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


