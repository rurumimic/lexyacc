#ifndef MGL_H
#define MGL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define DEFAULT_OUTFILE "menu.c"

extern char *progname;
extern char *usage;
extern int lineno;

void yyerror(char const *s);
int yylex(void);

// int main(int argc, char **argv);
void warning(char *s, char *t);

#endif // MGL_H
