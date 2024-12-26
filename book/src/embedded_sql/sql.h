#ifndef SQL_H
#define SQL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int lineno;
extern FILE *yyout; /* lex output file */

void yyerror(char const *s);
int yylex(void);

void un_sql(void);

void start_save(void);
void save_str(char *s);
void save_param(char *n);
void end_sql(void);

#define SV save_str(yytext) /* macro to save the text of a SQL token */
#define TOK(name) { SV; return name; } /* macro to save the text and return a token */

#endif // SQL_H
