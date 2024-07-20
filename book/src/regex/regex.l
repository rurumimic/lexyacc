%%
[\n\t ]     ;

-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) { printf("number\n"); }

\"[^"]*\"     { printf("string\n"); }

.    ECHO;
%%
int main()
{
      yylex();
}
