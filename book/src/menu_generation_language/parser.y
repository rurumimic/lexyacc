%{

#include "mgl.h"

%}

%union {
  char *string; /* string buffer */
  int cmd;      /* command value */
}

%token <string> QSTRING ID COMMENT
%token <cmd> SCREEN TITLE ITEM COMMAND ACTION EXECUTE EMPTY
%token <cmd> MENU QUIT IGNORE ATTRIBUTE VISIBLE INVISIBLE END

%type <cmd> action line attribute command
%type <string> id qstring

%start screens
%%

screens: screen
       | screens screen
       ;

screen: screen_name screen_contents screen_terminator
      | screen_name screen_terminator
      ;

screen_name: SCREEN id { start_screen($2); }
           | SCREEN    { start_screen(strdup("default")); }
           ;

screen_terminator: END id { end_screen($2); }
                 | END    { end_screen(strdup("default")); }
                 ;

screen_contents: titles lines
               ;

titles: /* empty */
      | titles title // left recursion
      ;

title: TITLE QSTRING { add_title($2); }
     ;

lines: line
     | lines line // left recursion
     ;

line: ITEM qstring command ACTION action attribute
      {
        item_str = $2;
        add_line($5, $6);
        $$ = ITEM;
      }
    ;

command: /* empty */ { cmd_str = strdup(""); }
       | COMMAND id  { cmd_str = $2; }
       ;

action: EXECUTE qstring
        {
          act_str = $2;
          $$ = EXECUTE;
        }
      | MENU id
        { /* make "menu_" $2 */
          act_str = malloc(strlen($2) + 6);
          strcpy(act_str, "menu_");
          strcat(act_str, $2);
          free($2);
          $$ = MENU;
        }
      | QUIT   { $$ = QUIT; }
      | IGNORE { $$ = IGNORE; }
      ;

attribute: /* empty */         { $$ = VISIBLE; }
         | ATTRIBUTE VISIBLE   { $$ = VISIBLE; }
         | ATTRIBUTE INVISIBLE { $$ = INVISIBLE; }
         ;

id: ID { $$ = $1; }
  | QSTRING
    {
      warning("String literal inappropriate", (char *)0);
      $$ = $1; /* but use it anyway */
    }
  ;

qstring: QSTRING { $$ = $1; }
       | ID
         {
            warning("Non-string literal inappropriate", (char *)0);
            $$ = $1; /* but use it anyway */
         }
       ;


%%

