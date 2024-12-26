#include "sql.h"

#define NPARAM 20       /* max params per function */
char save_buf[2000];    /* buffer for SQL command */
char *savebp;           /* current buffer pointer */
char *varnames[NPARAM]; /* parameter names */

void start_save(void) {
  savebp = save_buf;
}

void save_str(char *s) {
  strcpy(savebp, s);
  savebp += strlen(s);
}

void save_param(char *n) {
  int i;
  char pbuf[10];

  // look up the variabble name in the table
  for (i = 1; i < NPARAM; i++) {
    if (!varnames[i]) {
      varnames[i] = strdup(n); // not there, enter it
      break;
    }

    if (!strcmp(varnames[i], n)) {
      break; // already present
    }
  }

  if (i >= NPARAM) {
    yyerror("Too many parameter references");
    exit(1);
  }

  sprintf(pbuf, " #%d", i); // save #n reference by variable number
  save_str(pbuf);
}

void end_sql(void) {
  int i;
  register char *cp;

  savebp--; // back over the closing semicolon
 
  // call exec_sql function
  fprintf(yyout, "exec_sql(\"");

  // write out saved buffer as a big C string starting new lines as needed
  for (cp = save_buf, i = 20; cp < savebp; cp++, i++) {
    if (i > 70) { // start a new line
      fprintf(yyout, "\\\n");
      i = 0;
    }
    putc(*cp, yyout);
  }
  putc('\"', yyout);

  // pass address of every referenced variable
  for (i = 1; i < NPARAM; i++) {
    if (!varnames[i]) {
       break;
    }
    fprintf(yyout, ", &%s", varnames[i]);
    free(varnames[i]);
    varnames[i] = 0;
  }

  fprintf(yyout, ");\n");

  un_sql(); // return scanner to regular mode
}

