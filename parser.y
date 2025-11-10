%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(const char *s);

extern FILE *yyin;
extern FILE *yyout;
extern int yylineno;
extern char *yytext;
extern int yychar;

int yydebug = 0;

char *sdup(const char *s) {
    if (!s) return NULL;
    char *r = malloc(strlen(s) + 1);
    strcpy(r, s);
    return r;
}

char *concat2(const char *a, const char *b) {
    if (!a) a = "";
    if (!b) b = "";
    char *r = malloc(strlen(a) + strlen(b) + 1);
    strcpy(r, a);
    strcat(r, b);
    return r;
}

char *concat3(const char *a, const char *b, const char *c) {
    char *t = concat2(a,b);
    char *r = concat2(t,c);
    free(t);
    return r;
}

char *concat4(const char *a, const char *b, const char *c, const char *d) {
    char *t1 = concat2(a, b);
    char *t2 = concat2(t1, c);
    free(t1);
    char *r = concat2(t2, d);
    free(t2);
    return r;
}

char *add_indent(const char *code) {
    if (!code) return sdup("");
    const int indent = 4;
    size_t cap = strlen(code) * 2 + 128;
    char *res = malloc(cap);
    res[0] = '\0';
    const char *cur = code;
    while (*cur) {
        for(int i=0;i<indent;i++) strcat(res, " ");
        while(*cur && *cur!='\n' && *cur!='\r') {
            char tmp[2] = {*cur,0};
            strcat(res,tmp);
            cur++;
        }
        strcat(res,"\n");
        if(*cur=='\r' && *(cur+1)=='\n') cur+=2;
        else if(*cur=='\n' || *cur=='\r') cur++;
    }
    return res;
}
%}

%union {
    char *str;
}

%token <str> IDENTIFIER STRINGVAL NUMBER FLOATVAL BOOLVAL
%token INT DOUBLE FLOAT STRING BOOL VOID
%token IF ELSE FOR WHILE RETURN 
%token PRINT PRINTLN
%token EQUAL PLUSEQUAL MINUSEQUAL PLUSPLUS MINUSMINUS
%token PLUS MINUS MULTIPLY DIVIDE MOD 
%token LT GT LEQ GEQ EQEQ NEQ 
%token AND OR
%token LBRACE RBRACE LPAREN RPAREN 
%token COMMA SEMICOLON
%token LBRACKET RBRACKET POINT
%token LIST NEW

%left OR
%left AND
%nonassoc EQEQ NEQ LT GT LEQ GEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE MOD
%left POINT LBRACKET

%type <str> program          function_decl  stmt
%type <str> var_decl         list_decl      print_stmt
%type <str> expr             if_stmt        while_stmt
%type <str> for_stmt         block          expr_stmt
%type <str> type             expr_list      items
%type <str> arg_list

%start program

%%

program:
    function_decl { 
        if(yyout && $1) {
            fprintf(yyout, "%s\n", $1);
            fprintf(yyout, "\nif __name__ == \"__main__\":\n    main()\n");
        }
        if($1) free($1); 
    }
;

function_decl:
    VOID IDENTIFIER LPAREN RPAREN block
    {
        char *hdr = concat3("def ", $2, "():");
        char *b = add_indent($5);
        $$ = concat3(hdr, "\n", b);
        free($2); free($5); free(hdr); free(b);
    }
;

block:
    LBRACE items RBRACE { $$ = $2; }
;

items:
    /* empty */ { $$ = sdup(""); }
  | items stmt { $$ = concat2($1, $2); free($1); free($2); }
;

stmt:
    var_decl SEMICOLON        { $$ = concat2($1, "\n"); free($1); }
    | list_decl SEMICOLON     { $$ = concat2($1, "\n"); free($1); }
    | print_stmt SEMICOLON    { $$ = concat2($1, "\n"); free($1); }
    | expr_stmt SEMICOLON     { $$ = concat2($1, "\n"); free($1); }
    | if_stmt                 { $$ = $1; }
    | while_stmt              { $$ = $1; }
    | for_stmt                { $$ = $1; }
;

var_decl:
    type IDENTIFIER EQUAL expr { $$ = concat3($2, " = ", $4); free($2); free($4); }
;

list_decl:
    LIST LT type GT IDENTIFIER EQUAL NEW LIST LT type GT LPAREN RPAREN
    {
        $$ = concat2($5, " = []");
        free($5);
    }
;

type:
    INT       { $$ = sdup(""); }
    | DOUBLE  { $$ = sdup(""); }
    | FLOAT   { $$ = sdup(""); }
    | STRING  { $$ = sdup(""); }
    | BOOL    { $$ = sdup(""); }
;

print_stmt:
    PRINTLN LPAREN expr RPAREN { $$ = concat3("print(", $3, ")"); free($3); }
    | PRINT LPAREN expr RPAREN { $$ = concat3("print(", $3, ", end='')"); free($3); }
    | PRINTLN LPAREN RPAREN { $$ = sdup("print()"); }
    | PRINT LPAREN RPAREN { $$ = sdup("print('', end='')"); }
;

expr:
    STRINGVAL   { $$ = $1; }
    | NUMBER    { $$ = $1; }
    | FLOATVAL  { $$ = $1; }
    | BOOLVAL   { $$ = $1; }
    | IDENTIFIER { $$ = $1; }
    | expr AND expr   { $$ = concat3($1, " and ", $3); free($1); free($3); }
    | expr OR expr    { $$ = concat3($1, " or ", $3); free($1); free($3); }
    | expr PLUS expr   { $$ = concat3($1, " + ", $3); free($1); free($3); }
    | expr MINUS expr  { $$ = concat3($1, " - ", $3); free($1); free($3); }
    | expr MULTIPLY expr { $$ = concat3($1, " * ", $3); free($1); free($3); }
    | expr DIVIDE expr { $$ = concat3($1, " / ", $3); free($1); free($3); }
    | expr MOD expr    { $$ = concat3($1, " % ", $3); free($1); free($3); }
    | expr LT expr     { $$ = concat3($1, " < ", $3); free($1); free($3); }
    | expr GT expr     { $$ = concat3($1, " > ", $3); free($1); free($3); }
    | expr LEQ expr    { $$ = concat3($1, " <= ", $3); free($1); free($3); }
    | expr GEQ expr    { $$ = concat3($1, " >= ", $3); free($1); free($3); }
    | expr EQEQ expr   { $$ = concat3($1, " == ", $3); free($1); free($3); }
    | expr NEQ expr    { $$ = concat3($1, " != ", $3); free($1); free($3); }
    | LPAREN expr RPAREN { $$ = concat3("(", $2, ")"); free($2); }
    | expr POINT IDENTIFIER LPAREN expr_list RPAREN
    {
        if (strcmp($3, "add") == 0) {
            $$ = concat3($1, ".append(", $5);
            $$ = concat2($$, ")");
        } else {
            char *tmp = concat3($1, ".", $3);
            $$ = concat3(tmp, "(", $5);
            $$ = concat2($$, ")");
            free(tmp);
        }
        free($1); free($3); free($5);
    }
    | expr POINT IDENTIFIER
    {
        if (strcmp($3, "length") == 0) {
            $$ = concat3("len(", $1, ")");
        } else {
            $$ = concat3($1, ".", $3);
        }
        free($1); free($3);
    }
    | expr LBRACKET expr RBRACKET
    {
        $$ = concat3($1, "[", $3);
        $$ = concat2($$, "]");
        free($1); free($3);
    }
    | IDENTIFIER LPAREN arg_list RPAREN
    {
        $$ = concat4($1, "(", $3, ")");
        free($1); free($3);
    }
;

arg_list:
      /* пусто */      { $$ = strdup(""); }
    | expr             { $$ = strdup($1); free($1); }
    | arg_list COMMA expr  { $$ = concat3($1, ", ", $3); free($1); free($3); }
    ;

expr_list:
    /* empty */ { $$ = sdup(""); }
    | expr { $$ = $1; }
    | expr_list COMMA expr { $$ = concat3($1, ", ", $3); free($1); free($3); }
;

if_stmt:
    IF LPAREN expr RPAREN block
    {
        char *hdr = concat3("if ", $3, ":");
        char *b = add_indent($5);
        $$ = concat3(hdr, "\n", b);
        free($3); free($5); free(hdr); free(b);
    }
  | IF LPAREN expr RPAREN block ELSE if_stmt
    {
        char *hdr = concat3("if ", $3, ":");
        char *b1 = add_indent($5);
        char *b2 = add_indent($7);
        $$ = concat3(hdr, "\n", b1);
        $$ = concat3($$, "else:\n", b2);
        free($3); free($5); free($7); free(hdr); free(b1); free(b2);
    }
  | IF LPAREN expr RPAREN block ELSE block
    {
        char *hdr = concat3("if ", $3, ":");
        char *b1 = add_indent($5);
        char *b2 = add_indent($7);
        $$ = concat3(hdr, "\n", b1);
        $$ = concat3($$, "else:\n", b2);
        free($3); free($5); free($7); free(hdr); free(b1); free(b2);
    }
;

while_stmt:
    WHILE LPAREN expr RPAREN block
    {
        char *hdr = concat3("while ", $3, ":");
        char *b = add_indent($5);
        $$ = concat3(hdr, "\n", b);
        free($3); free($5); free(hdr); free(b);
    }
;

for_stmt:
    FOR LPAREN type IDENTIFIER EQUAL expr SEMICOLON IDENTIFIER LT expr SEMICOLON IDENTIFIER PLUSPLUS RPAREN block
    {
        char *hdr = concat3("for ", $4, " in range(");
        hdr = concat3(hdr, $6, ", ");
        hdr = concat3(hdr, $10, "):");
        char *b = add_indent($15);
        $$ = concat3(hdr, "\n", b);
        free($4); free($6); free($10); free($15); free(hdr); free(b);
    }
;

expr_stmt:
    IDENTIFIER EQUAL expr { $$ = concat3($1, " = ", $3); free($1); free($3); }
    | IDENTIFIER PLUSPLUS { $$ = concat2($1, " += 1"); free($1); }
    | IDENTIFIER MINUSMINUS { $$ = concat2($1, " -= 1"); free($1); }
    | expr { $$ = $1; }
;

%%

int main(void) {
    yyout = fopen("output.txt","w");
    if(!yyout) { printf("Cannot open output file\n"); return -1; }

    char fname[256];
    printf("Enter file name: ");
    scanf("%255s", fname);

    yyin = fopen(fname, "r");
    if(!yyin) { printf("Cannot open input file: %s\n", fname); fclose(yyout); return -1; }

    printf("Starting translation...\n");
    int res = yyparse();
    printf("Translation finished with result: %d\n", res);

    fclose(yyin);
    fclose(yyout);
    return res;
}

int yyerror(const char *s) {
    if (yychar == 0) {
        fprintf(stderr, "Parse error (EOF) at line %d: %s\n", yylineno, s ? s : "");
    } else {
        const char *tname = "unknown";
        switch(yychar) {
            case IDENTIFIER: tname = "IDENTIFIER"; break;
            case NUMBER: tname = "NUMBER"; break;
            case STRINGVAL: tname = "STRINGVAL"; break;
            case BOOLVAL: tname = "BOOLVAL"; break;
            case INT: tname = "INT"; break;
            case DOUBLE: tname = "DOUBLE"; break;
            case FLOAT: tname = "FLOAT"; break;
            case STRING: tname = "STRING"; break;
            case BOOL: tname = "BOOL"; break;
            case VOID: tname = "VOID"; break;
            case IF: tname = "IF"; break;
            case ELSE: tname = "ELSE"; break;
            case FOR: tname = "FOR"; break;
            case WHILE: tname = "WHILE"; break;
            case RETURN: tname = "RETURN"; break;
            case PRINT: tname = "PRINT"; break;
            case PRINTLN: tname = "PRINTLN"; break;
            case EQUAL: tname = "EQUAL"; break;
            case PLUS: tname = "PLUS"; break;
            case MINUS: tname = "MINUS"; break;
            case MULTIPLY: tname = "MULTIPLY"; break;
            case DIVIDE: tname = "DIVIDE"; break;
            case LT: tname = "LT"; break;
            case GT: tname = "GT"; break;
            case SEMICOLON: tname = "SEMICOLON"; break;
            case LBRACE: tname = "LBRACE"; break;
            case RBRACE: tname = "RBRACE"; break;
            case LPAREN: tname = "LPAREN"; break;
            case RPAREN: tname = "RPAREN"; break;
            case COMMA: tname = "COMMA"; break;
            default: 
                if (yychar > 0 && yychar < 128) {
                    static char char_token[2] = {0};
                    char_token[0] = (char)yychar;
                    tname = char_token;
                }
        }
        fprintf(stderr, "Parse error at line %d: %s\n  token: %s  text: \"%s\"\n",
                yylineno, s ? s : "", tname, yytext ? yytext : "");
    }
    return 0;
}