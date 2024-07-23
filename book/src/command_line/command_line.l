/* definition section */

/* raw C code */
%{
#define YY_NO_INPUT
#undef input
#undef unput
int input(void);
void unput(int ch);
unsigned int verbose;
unsigned int fname;
char *progName;
%}

/* definitions */
%s FNAME

/* rules section */
%%

[ ]+ ; /* ignore white spaces */ 

-h |
"-?" |
-help { printf("usage: %s [-help | -h | -?] [-vebose | -v] [(-file | -f) filename]\n", progName); }

-v |
-verbose { printf("verbose mode is on.\n"); verbose = 1; }

-f |
-file { BEGIN FNAME; fname = 1; }

<FNAME>[^ ]+ { printf("use file: %s\n", yytext); BEGIN 0; fname = 2; }

[^ ]+ ECHO;

%%

/* user subroutines section */

char **targv;
char **arglim;

int main(int argc, char **argv)
{
  printf("argc: %d\n", argc);
  for (int i = 1; i < argc; i++) {
    printf("argv[%d]: %s\n", i, argv[i]);
  }
  printf("---\n");

  progName = *argv;
  targv = argv + 1;
  arglim = argv + argc;
  yylex();
  if (fname < 2) {
    printf("No file name specified: %d\n", fname);
  }
  return 0;
}

static unsigned int offset = 0;

int input(void) {
  char c;

  if (targv >= arglim) {
    return 0; // EOF
  }

  // end of argument
  if ((c = targv[0][offset++]) != '\0') {
    return c; // move to the next
  }

  targv++;
  offset = 0;

  return '!';
}

void unput(int ch) {
  if (ch == 0) {
    return; // ignore EOF
  }

  if (offset) {
    offset--;
    return;
  }

  targv--; // back to previous argument
  offset = strlen(*targv);
}

