%{

#include "parser.h" // <- #include "y.tab.h"
#include "sql.h"

%}

%s SQL

%%

EXEC[ \t]+SQL                   { BEGIN SQL; start_save(); }

<SQL>ALL                        TOK(ALL)
<SQL>AND                        TOK(AND)
<SQL>AVG                        TOK(AMMSC)
<SQL>MIN                        TOK(AMMSC)
<SQL>MAX                        TOK(AMMSC)
<SQL>SUM                        TOK(AMMSC)
<SQL>COUNT                      TOK(AMMSC)
<SQL>ANY                        TOK(ANY)
<SQL>AS                         TOK(AS)
<SQL>ASC                        TOK(ASC)
<SQL>AUTHORIZATION              TOK(AUTHORIZATION)
<SQL>BETWEEN                    TOK(BETWEEN)
<SQL>BY                         TOK(BY)
<SQL>CHAR(ACTER)?               TOK(CHARACTER)
<SQL>CHECK                      TOK(CHECK)
<SQL>CLOSE                      TOK(CLOSE)
<SQL>COMMIT                     TOK(COMMIT)
<SQL>CONTINUE                   TOK(CONTINUE)
<SQL>CREATE                     TOK(CREATE)
<SQL>CURRENT                    TOK(CURRENT)
<SQL>CURSOR                     TOK(CURSOR)
<SQL>DECIMAL                    TOK(DECIMAL)
<SQL>DECLARE                    TOK(DECLARE)
<SQL>DEFAULT                    TOK(DEFAULT)
<SQL>DELETE                     TOK(DELETE)
<SQL>DESC                       TOK(DESC)
<SQL>DISTINCT                   TOK(DISTINCT)
<SQL>DOUBLE                     TOK(DOUBLE)
<SQL>ESCAPE                     TOK(ESCAPE)
<SQL>EXISTS                     TOK(EXISTS)
<SQL>FETCH                      TOK(FETCH)
<SQL>FLOAT                      TOK(FLOAT)
<SQL>FOR                        TOK(FOR)
<SQL>FOREIGN                    TOK(FOREIGN)
<SQL>FOUND                      TOK(FOUND)
<SQL>FROM                       TOK(FROM)
<SQL>GO[ \t]*TO                 TOK(GOTO)
<SQL>GRANT                      TOK(GRANT)
<SQL>GROUP                      TOK(GROUP)
<SQL>HAVING                     TOK(HAVING)
<SQL>IN                         TOK(IN)
<SQL>INDICATOR                  TOK(INDICATOR)
<SQL>INSERT                     TOK(INSERT)
<SQL>INT(EGER)?                 TOK(INTEGER)
<SQL>INTO                       TOK(INTO)
<SQL>IS                         TOK(IS)
<SQL>KEY                        TOK(KEY)
<SQL>LANGUAGE                   TOK(LANGUAGE)
<SQL>LIKE                       TOK(LIKE)
<SQL>NOT                        TOK(NOT)
<SQL>NULL                       TOK(NULLX)
<SQL>NUMERIC                    TOK(NUMERIC)
<SQL>OF                         TOK(OF)
<SQL>ON                         TOK(ON)
<SQL>OPEN                       TOK(OPEN)
<SQL>OPTION                     TOK(OPTION)
<SQL>OR                         TOK(OR)
<SQL>ORDER                      TOK(ORDER)
<SQL>PRECISION                  TOK(PRECISION)
<SQL>PRIMARY                    TOK(PRIMARY)
<SQL>PRIVILEGES                 TOK(PRIVILEGES)
<SQL>PROCEDURE                  TOK(PROCEDURE)
<SQL>PUBLIC                     TOK(PUBLIC)
<SQL>REAL                       TOK(REAL)
<SQL>REFERENCES                 TOK(REFERENCES)
<SQL>ROLLBACK                   TOK(ROLLBACK)
<SQL>SCHEMA                     TOK(SCHEMA)
<SQL>SELECT                     TOK(SELECT)
<SQL>SET                        TOK(SET)
<SQL>SMALLINT                   TOK(SMALLINT)
<SQL>SOME                       TOK(SOME)
<SQL>SQLCODE                    TOK(SQLCODE)
<SQL>TABLE                      TOK(TABLE)
<SQL>TO                         TOK(TO)
<SQL>UNION                      TOK(UNION)
<SQL>UNIQUE                     TOK(UNIQUE)
<SQL>UPDATE                     TOK(UPDATE)
<SQL>USER                       TOK(USER)
<SQL>VALUES                     TOK(VALUES)
<SQL>VIEW                       TOK(VIEW)
<SQL>WHENEVER                   TOK(WHENEVER)
<SQL>WHERE                      TOK(WHERE)
<SQL>WITH                       TOK(WITH)
<SQL>WORK                       TOK(WORK)

    /* punctuation */

<SQL>"="                        |
<SQL>"<>"                       |
<SQL>"<"                        |
<SQL>">"                        |
<SQL>"<="                       |
<SQL>">="                       TOK(COMPARISON)

<SQL>[-+*/(),.;]                TOK(yytext[0])

    /* names */
<SQL>[A-Za-z][A-Za-z0-9_]*      TOK(NAME)

    /* parameters */
<SQL>":"[A-Za-z][A-Za-z0-9_]*   {
                                  save_param(yytext + 1);
                                  return PARAMETER;
                                }

    /* numbers */

<SQL>[0-9]+                         |
<SQL>[0-9]+"."[0-9]*                |
<SQL>"."[0-9]*                      TOK(INTNUM)

<SQL>[0-9]+[eE][+-]?[0-9]+          |
<SQL>[0-9]+"."[0-9]*[eE][+-]?[0-9]+ |
<SQL>"."[0-9]*[eE][+-]?[0-9]+       TOK(APPROXNUM)

    /* strings */

<SQL>'[^'\n]*'                  {
                                  int c = input();

                                  unput(c); /* just peeking */
                                  if(c != '\'') {
                                    SV;
                                    return STRING;
                                  } else
                                  yymore();
                                }

<SQL>'[^'\n]*$                  { yyerror("Unterminated string"); }

<SQL>\n                         { save_str(" "); lineno++; }
\n                              { lineno++; ECHO; }

<SQL>[ \t\r]+                   save_str(" "); /* white space */

<SQL>"--".*                     ; /* comment */

.                               ECHO; /* random non-SQL text */
%%

void yyerror(const char *s) {
  printf("%d: %s at %s\n", lineno, s, yytext);
}

/* leave SQL lexing mode */
void un_sql(void) {
  BEGIN INITIAL;
}

