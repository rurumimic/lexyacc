%{

#include "parser.h" // <- #include "y.tab.h"
#include "sql.h"

%}

%e 1200

%%

ADA                             { return ADA; /* literal keyword tokens */ }
ALL                             { return ALL; }
AND                             { return AND; }
AVG                             { return AMMSC; }
MIN                             { return AMMSC; }
MAX                             { return AMMSC; }
SUM                             { return AMMSC; }
COUNT                           { return AMMSC; }
ANY                             { return ANY; }
AS                              { return AS; }
ASC                             { return ASC; }
AUTHORIZATION                   { return AUTHORIZATION; }
BETWEEN                         { return BETWEEN; }
BY                              { return BY; }
C                               { return C; }
CHAR(ACTER)?                    { return CHARACTER; }
CHECK                           { return CHECK; }
CLOSE                           { return CLOSE; }
COBOL                           { return COBOL; }
COMMIT                          { return COMMIT; }
CONTINUE                        { return CONTINUE; }
CREATE                          { return CREATE; }
CURRENT                         { return CURRENT; }
CURSOR                          { return CURSOR; }
DECIMAL                         { return DECIMAL; }
DECLARE                         { return DECLARE; }
DEFAULT                         { return DEFAULT; }
DELETE                          { return DELETE; }
DESC                            { return DESC; }
DISTINCT                        { return DISTINCT; }
DOUBLE                          { return DOUBLE; }
ESCAPE                          { return ESCAPE; }
EXISTS                          { return EXISTS; }
FETCH                           { return FETCH; }
FLOAT                           { return FLOAT; }
FOR                             { return FOR; }
FOREIGN                         { return FOREIGN; }
FORTRAN                         { return FORTRAN; }
FOUND                           { return FOUND; }
FROM                            { return FROM; }
GO[ \t]*TO                      { return GOTO; }
GRANT                           { return GRANT; }
GROUP                           { return GROUP; }
HAVING                          { return HAVING; }
IN                              { return IN; }
INDICATOR                       { return INDICATOR; }
INSERT                          { return INSERT; }
INT(EGER)?                      { return INTEGER; }
INTO                            { return INTO; }
IS                              { return IS; }
KEY                             { return KEY; }
LANGUAGE                        { return LANGUAGE; }
LIKE                            { return LIKE; }
MODULE                          { return MODULE; }
NOT                             { return NOT; }
NULL                            { return NULLX; }
NUMERIC                         { return NUMERIC; }
OF                              { return OF; }
ON                              { return ON; }
OPEN                            { return OPEN; }
OPTION                          { return OPTION; }
OR                              { return OR; }
ORDER                           { return ORDER; }
PASCAL                          { return PASCAL; }
PLI                             { return PLI; }
PRECISION                       { return PRECISION; }
PRIMARY                         { return PRIMARY; }
PRIVILEGES                      { return PRIVILEGES; }
PROCEDURE                       { return PROCEDURE; }
PUBLIC                          { return PUBLIC; }
REAL                            { return REAL; }
REFERENCES                      { return REFERENCES; }
ROLLBACK                        { return ROLLBACK; }
SCHEMA                          { return SCHEMA; }
SELECT                          { return SELECT; }
SET                             { return SET; }
SMALLINT                        { return SMALLINT; }
SOME                            { return SOME; }
SQLCODE                         { return SQLCODE; }
TABLE                           { return TABLE; }
TO                              { return TO; }
UNION                           { return UNION; }
UNIQUE                          { return UNIQUE; }
UPDATE                          { return UPDATE; }
USER                            { return USER; }
VALUES                          { return VALUES; }
VIEW                            { return VIEW; }
WHENEVER                        { return WHENEVER; }
WHERE                           { return WHERE; }
WITH                            { return WITH; }
WORK                            { return WORK; }

"="                             |
"<>"                            |
"<"                             |
">"                             |
"<="                            |
">="                            { return COMPARISON; /* punctuation tokens */ }

[-+*/:(),.;]                    { return yytext[0]; }

[A-Za-z][A-Za-z0-9_]*           { return NAME; /* names */ }

[0-9]+                          |
[0-9]+"."[0-9]*                 |
"."[0-9]*                       { return INTNUM; /* numbers */ }

[0-9]+[eE][+-]?[0-9]+           |
[0-9]+"."[0-9]*[eE][+-]?[0-9]+  |
"."[0-9]*[eE][+-]?[0-9]+        { return APPROXNUM; }

'[^'\n]*'                       {
                                  /* strings */
                                  int c = input();
                                  unput(c); /* just peeking */
                                  if (c != '\'') {
                                    return STRING;
                                  } else {
                                    yymore();
                                  }
                                }

'[^'\n]*$                       { yyerror("Unterminated string"); }

\n                              { lineno++; /* whitespace */ }
[ \t\r]+                        ; /* ignore whitespace */
"--".*                          ; /* ignore comments */

.                               { yyerror("Invalid character"); /* unknown characters */ }

%%

void yyerror(const char *s) {
  printf("%d: %s at %s\n", lineno, s, yytext);
}

