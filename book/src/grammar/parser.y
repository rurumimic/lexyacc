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
  simple_sentence { printf("Parsed a simple sentence.\n"); }
| compound_sentence { printf("Parsed a compound sentence.\n"); }
;

simple_sentence:
  subject verb object
| subject verb object prep_phrase
;

compound_sentence:
  simple_sentence CONJUNCTION simple_sentence
| compound_sentence CONJUNCTION simple_sentence
;

subject:
  NOUN
| PRONOUN
| ADJECTIVE subject
;

verb:
  VERB
| ADVERB VERB
| verb VERB
;

object:
  NOUN
| ADJECTIVE object
;

prep_phrase:
  PREPOSITION NOUN
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

