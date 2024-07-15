%{
/*
 * A lexer for the basic grammar to use for recognizing English sentences.
 */
  #include <stdio.h>

  void yyerror(char const *s);
  int yylex(void);

%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION

%%
sentence:
  subject VERB object { printf("Sentence is valid.\n"); }
;

subject:
  NOUN
| PRONOUN
;

object:
  NOUN
;
%%

extern FILE *yyin;

int main(void) {
  do {
    yyparse();
  } while (!feof(yyin));
  return 0;
}

void yyerror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

