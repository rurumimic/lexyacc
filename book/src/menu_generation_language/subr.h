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
};

extern struct item *item_list;
extern struct item *last_item;

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
extern char *screen_init[];
extern char *menu_init[];
extern char *menu_runtime[];

#endif // SUBR_H

