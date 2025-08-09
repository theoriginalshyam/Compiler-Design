%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_num = 1;
FILE *error_file;

void print_token(const char* token, const char* lexeme);
%}

%option noyywrap

D       [0-9]
L       [a-zA-Z_]
ID      {L}({L}|{D})*
WS      [ \t\r]+

%%

"if"        { print_token("keyword", yytext); }
"else"      { print_token("keyword", yytext); }
"while"     { print_token("keyword", yytext); }
"return"    { print_token("keyword", yytext); }

{ID}        { print_token("identifier", yytext); }
{D}+        { print_token("number", yytext); }
\"([^\\"]|\\.)*\" { print_token("string", yytext); }

"+"         { print_token("plus", yytext); }
"-"         { print_token("minus", yytext); }
"*"         { print_token("mul", yytext); }
"/"         { print_token("div", yytext); }
"="         { print_token("assign", yytext); }
";"         { print_token("semicolon", yytext); }
"("         { print_token("lparen", yytext); }
")"         { print_token("rparen", yytext); }
"{"         { print_token("lbrace", yytext); }
"}"         { print_token("rbrace", yytext); }

"//".*      { /* single-line comment, ignore */ }
"/*"([^*]|\*+[^*/])*\*+"/"    { /* do nothing */ ; }

\n          { line_num++; }
{WS}        { /* ignore whitespace */ }

.           { fprintf(error_file, "Lexical Error: Invalid character '%s' at line %d\n", yytext, line_num); }

%%

void print_token(const char* token, const char* lexeme) {
    printf("%-15s %s\n", lexeme, token);
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <input_file> <error_file>\n", argv[0]);
        exit(1);
    }
    FILE *input = fopen(argv[1], "r");
    if (!input) {
        perror("Error opening input file");
        exit(1);
    }
    error_file = fopen(argv[2], "w");
    if (!error_file) {
        perror("Error opening error file");
        exit(1);
    }
    yyin = input;
    yylex();
    fclose(input);
    fclose(error_file);
    return 0;
}
