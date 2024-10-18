#ifndef CALCULATOR_H
#define CALCULATOR_H

#define NSYMS 20 /* maximum number of symbols */

struct symtab {
  char *name;
  double (*funcptr)();
  double value;
};

extern struct symtab symtab[NSYMS];

struct symtab *symlook(char *s);

#endif // CALCULATOR_H
