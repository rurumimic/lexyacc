#ifndef SUBR_H
#define SUBR_H

#include <stdio.h>

#define SCREEN_SIZE 80

extern FILE *yyin, *yyout;

extern int screen_done; /* 1 if done, 0 otherwise */

/* extra argument */
extern char *act_str;
extern char *cmd_str;
extern char *item_str;

static char current_screen[100]; /* reasonable? */
static int done_start_init;
static int done_end_init;
static int current_line;
struct item {
  char *desc;        /* item description */
  char *cmd;         /* command */
  int action;        /* action to take */
  char *act_str;     /* action operation */
  int attribute;     /* visible/invisible */
  struct item *next; /* next member of list */
} *item_list, *last_item;

int start_screen(char *name);
int add_title(char *line);
void add_line(int action, int attrib);
int end_screen(char *name);
void process_items();
void dump_data(char **array);
void end_file();
int check_name(char *name);
void cfree(char *); /* free if not null */

/*
 * MGL Runtime support code
 */

char *screen_init[] = {
	"/* initialization information */",
	"static int init;\n",
	"#include <curses.h>",
	"#include <sys/signal.h>",
	"#include <ctype.h>",
	"#include \"mglyac.h\"\n",
	"/* structure used to store menu items */",
	"struct item {",
	"\tchar *desc;",
	"\tchar *cmd;",
	"\tint  action;",
	"\tchar   *act_str;     /* execute string */",
	"\tint (*act_menu)();   /* call appropriate function */",
	"\tint  attribute;",
	"};\n",
	0,
};

char *menu_init[] = {
	"menu_init()",
	"{",
	"\tvoid menu_cleanup();\n",
	"\tsignal(SIGINT, menu_cleanup);",
	"\tinitscr();",
	"\tcrmode();",
	"}\n\n",
	"menu_cleanup()",
	"{",
	"\tmvcur(0, COLS - 1, LINES - 1, 0);",
	"\tendwin();",
	"}\n",
	0,
};

char *menu_runtime[] = {
"/* runtime */",
"",
"menu_runtime(items)",
"struct item *items;",
"{",
"\tint visible = 0;",
"\tint choice = 0;",
"\tstruct item *ptr;",
"\tchar buf[BUFSIZ];",
"",
"\tfor(ptr = items; ptr->desc != 0; ptr++) {",
"\t\taddch('\\n'); /* skip a line */",
"\t\tif(ptr->attribute == VISIBLE) {",
"\t\t\tvisible++;",
"\t\t\tprintw(\"\\t%d) %s\",visible,ptr->desc);",
"\t\t}",
"\t}",
"",
"\taddstr(\"\\n\\n\\t\"); /* tab out so it looks nice */",
"\trefresh();",
"",
"\tfor(;;)",
"\t{",
"\t\tint i, nval;",
"",
"\t\tgetstr(buf);",
"",
"\t\t/* numeric choice? */",
"\t\tnval = atoi(buf);",
"",
"\t\t/* command choice ? */",
"\t\ti = 0;",
"\t\tfor(ptr = items; ptr->desc != 0; ptr++) {",
"\t\t\tif(ptr->attribute != VISIBLE)",
"\t\t\t\tcontinue;",
"\t\t\ti++;",
"\t\t\tif(nval == i)",
"\t\t\t\tbreak;",
"\t\t\tif(!casecmp(buf, ptr->cmd))",
"\t\t\t\tbreak;",
"\t\t}",
"",
"\t\tif(!ptr->desc)",
"\t\t\tcontinue;\t/* no match */",
"",
"\t\tswitch(ptr->action)",
"\t\t{",
"\t\tcase QUIT:",
"\t\t\treturn 0;",
"\t\tcase IGNORE:",
"\t\t\trefresh();",
"\t\t\tbreak;",
"\t\tcase EXECUTE:",
"\t\t\trefresh();",
"\t\t\tsystem(ptr->act_str);",
"\t\t\tbreak;",
"\t\tcase MENU:",
"\t\t\trefresh();",
"\t\t\t(*ptr->act_menu)();",
"\t\t\tbreak;",
"\t\tdefault:",
"\t\t\tprintw(\"default case, no action\\n\");",
"\t\t\trefresh();",
"\t\t\tbreak;",
"\t\t}",
"\t\trefresh();",
"\t}",
"}",
"",
"casecmp(char *p, char *q)",
"{",
"\tint pc, qc;",
"",
"\tfor(; *p != 0; p++, q++) {",
"\t\tpc = tolower(*p);",
"\t\tqc = tolower(*q);",
"",
"\t\tif(pc != qc)",
"\t\t\tbreak;",
"\t}",
"\treturn pc-qc;",
"}",
0
};

#endif // SUBR_H

