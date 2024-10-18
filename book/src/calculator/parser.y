%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "calculator.h"

void yyerror(char const *s);
void addfunc(char *name, double (*func)());

// double vbltable[26]; // variable symbol table

struct symtab symtab[NSYMS]; // symbol table

%}

%start statement_list

%union {
  double dval;  // double value
  // int vblno; // variable number
  struct symtab *symp; // symbol table entry
}

// %token NAME NUMBER
// %token <vblno> NAME
%token <symp> NAME
%token <dval> NUMBER

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expression

%%

statement_list: statement '\n'
              | statement_list statement '\n'
              ;

/* statement: NAME '=' expression        { vbltable[$1] = $3; } */
statement: NAME '=' expression        { $1->value = $3; }
         | expression                 { printf("= %g\n", $1); }
         ;

/* explicitly precedence */

expression: expression '+' expression { $$ = $1 + $3; }
          | expression '-' expression { $$ = $1 - $3; }
          | expression '*' expression { $$ = $1 * $3; }
          | expression '/' expression {
              if ($3 == 0.0) {
                yyerror("divide by zero");
              } else {
                $$ = $1 / $3;
              }
            }
          | '-' expression %prec UMINUS { $$ = -$2; }
          | '(' expression ')'          { $$ =  $2; }
          | NUMBER                      { $$ =  $1; }
       /* | NAME                        { $$ =  vbltable[$1]; } */
          | NAME                        { $$ =  $1->value; }
          | NAME '(' expression ')'     {
              if ($1->funcptr) {
                $$ = ($1->funcptr)($3);
              } else {
                printf("%s not a function\n", $1->name);
                $$ = 0.0;
              }
            }
          ;

/* implicitly precedence

expression: expression '+' mulexp
          | expression '-' mulexp
          ;

mulexp: mulexp '*' primary
      | mulexp '/' primary
      | primary
      ;

primary: '(' expression ')'
       | '-' primary
       | NUMBER
       ;
*/

%%

int main(void) {
  extern double sqrt(), exp(), log();

  addfunc("sqrt", sqrt);
  addfunc("exp", exp);
  addfunc("log", log);

  yyparse();
  return 0;
}

void yyerror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

/* look up a symbol table entry, add if not present */
struct symtab *symlook(char *s) {
  char *p;
  struct symtab *sp;
  for (sp = symtab; sp < &symtab[NSYMS]; sp++) {
    /* is it already here? */
    if (sp->name && !strcmp(sp->name, s)) {
      return sp;
    }

    /* is it free */
    if (!sp->name) {
      sp->name = strdup(s);
      return sp;
    }

    /* otherwise continue to the next */
  }

  yyerror("Too many symbols");
  exit(1);
}

void addfunc(char *name, double (*func)()) {
  struct symtab *sp = symlook(name);
  sp->funcptr = func;
}

