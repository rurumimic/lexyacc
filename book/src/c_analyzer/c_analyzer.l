/* definition section */

/* raw C code */
%{
int comments, code, whiteSpace;
%}

/* definitions */
%s COMMENT

/* rules section */
%%

^[ \t]*"/*" { BEGIN COMMENT; /* enter comment eating state */ }
^[ \t]*"/*".*"*/"[ \t]*\n { comments++; /* self-contained comment */ }

<COMMENT>"*/"[ \t]*\n { BEGIN 0; comments++; }
<COMMENT>"*/"         { BEGIN 0; }
<COMMENT>\n           { comments++; }
<COMMENT>.\n          { comments++; }

^[ \t]*\n { whiteSpace++; }

.+"/*".*"*/".*\n { code++; }
.*"/*".*"*/".+\n { code++; }
.+"/*".*\n       { code++; BEGIN COMMENT; }
.\n              { code++; }

. ; /* ignore white spaces */ 

%%

/* user subroutines section */

int main()
{
  yylex();
  printf("code: %d, comments %d, whitespace %d\n", code, comments, whiteSpace);
  return 0;
}

