#include "mglyac.h"

int main(int argc, char **argv) {
  char *outfile;
  char *infile;

  extern FILE *yyin, *yyout;

  progname = argv[0];

  if (argc > 3) {
    fprintf(stderr, usage, progname);
    return 1;
  }

  if (argc > 1) {
    infile = argv[1];
    yyin = fopen(infile, "r");
    if (yyin == NULL) {
      fprintf(stderr, "%s: cannot open %s\n", progname, infile);
      return 1;
    }
  }

  if (argc > 2) {
    outfile = argv[2];
  } else {
    outfile = DEFAULT_OUTFILE;
  }

  yyout = fopen(outfile, "w");
  if (yyout == NULL) {
    fprintf(stderr, "%s: cannot open %s\n", progname, outfile);
    return 1;
  }

  // read from yyin
  // writes to yyout
  yyparse();

  end_file();

  if (!screen_done) { // check EOF
    warning("Premature EOF", (char *)0);
    unlink(outfile); // remove bad file
    return 1;
  }

  return 0;
}

void warning(char *s, char *t) {
  fprintf(stderr, "%s: %s", progname, s);
  if (t) {
    fprintf(stderr, " %s", t);
  }
  fprintf(stderr, " line %d\n", lineno);
}

