/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    QSTRING = 258,                 /* QSTRING  */
    ID = 259,                      /* ID  */
    COMMENT = 260,                 /* COMMENT  */
    SCREEN = 261,                  /* SCREEN  */
    TITLE = 262,                   /* TITLE  */
    ITEM = 263,                    /* ITEM  */
    COMMAND = 264,                 /* COMMAND  */
    ACTION = 265,                  /* ACTION  */
    EXECUTE = 266,                 /* EXECUTE  */
    EMPTY = 267,                   /* EMPTY  */
    MENU = 268,                    /* MENU  */
    QUIT = 269,                    /* QUIT  */
    IGNORE = 270,                  /* IGNORE  */
    ATTRIBUTE = 271,               /* ATTRIBUTE  */
    VISIBLE = 272,                 /* VISIBLE  */
    INVISIBLE = 273,               /* INVISIBLE  */
    END = 274                      /* END  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define QSTRING 258
#define ID 259
#define COMMENT 260
#define SCREEN 261
#define TITLE 262
#define ITEM 263
#define COMMAND 264
#define ACTION 265
#define EXECUTE 266
#define EMPTY 267
#define MENU 268
#define QUIT 269
#define IGNORE 270
#define ATTRIBUTE 271
#define VISIBLE 272
#define INVISIBLE 273
#define END 274

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 12 "parser.y"

  char *string; /* string buffer */
  int cmd;      /* command value */

#line 110 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */