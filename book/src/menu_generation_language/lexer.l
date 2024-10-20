%{

#include "parser.h" // <- #include "y.tab.h"
#include "mgl.h"

%}

ws      [ \t]+
comment #.*
qstring \"[^\"\n]*[\"\n]
id      [a-zA-Z][a-zA-Z0-9]*
nl      \n

%%

{ws}      ; // skip whitespace
{comment} ;
{qstring} {
            yylval.string = strdup(yytext+1); /* skip open quote */
            if (yylval.string[yyleng-2] != '"') {
              warning("Unterminated character string", (char *)0);
            } else {
              yylval.string[yyleng-2] = '\0'; /* remove close quote */
              return QSTRING;
            }
          }
screen    { return SCREEN; }
title     { return TITLE; }
item      { return ITEM; }
command   { return COMMAND; }
action    { return ACTION; }
execute   { return EXECUTE; }
menu      { return MENU; }
quit      { return QUIT; }
ignore    { return IGNORE; }
attribute { return ATTRIBUTE; }
visible   { return VISIBLE; }
invisible { return INVISIBLE; }
end       { return END; }
id        {
            // if (yylval.cmd = keyword(yytext)) {
            //  return yylval.cmd;
            // }

            yylval.string = strdup(yytext);
            return ID;
          }
{nl}      { lineno++; }
.         { return yytext[0]; }

%%

/* alternative lex specification

static struct keyword {
  char *name;
  int value; // token value
} keywords[] = {
  { "screen", SCREEN },
  { "title", TITLE },
  { "item", ITEM },
  { "command", COMMAND },
  { "action", ACTION },
  { "execute", EXECUTE },
  { "menu", MENU },
  { "quit", QUIT },
  { "ignore", IGNORE },
  { "attribute", ATTRIBUTE },
  { "visible", VISIBLE },
  { "invisible", INVISIBLE },
  { "end", END },
  { NULL, 0 },
};

int keyword(char *string) {
  struct keyword *ptr = keywords;

  while (ptr->name != NULL) {
    if (strcmp(ptr->name, string) == 0) {
      return ptr->value;
    } else {
      ptr++;
    }
  }

  return 0; // not found
}
*/

