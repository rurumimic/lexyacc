%{

#include "parser.h" // <- #include "y.tab.h"
#include "calculator.h"
#include <math.h>

// extern int yylval;
// extern double vbltable[26]; // more complex parsers, defines yylval as a union

%}

%%

         /* [0-9]+ { yylval = atoi(yytext); return NUMBER; } */
         /* save the number in yylval
          * parser can access it with yylval
          */

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
      yylval.dval = atof(yytext);
      return NUMBER;
      }

[ \t] ; /* skip whitespace */
       /* [a-z] { yylval.vblno = yytext[0] - 'a'; return NAME; } */
[A-Za-z][A-Za-z0-9]* {
      // yylval.symp = symlook(yytext);
      struct symtab *sp = symlook(yytext);
      yylval.symp = sp;
      return NAME;
      }
"$"   { return 0; } /* end of line. 0 is a logical EOF */

       /* \n     return 0; */ /* end of line. 0 is a logical EOF */
\n    |
.     return yytext[0]; /* return other characters as they are */

%%
