/* definition section */

/* raw C code */
%{
unsigned int charCount = 0, wordCount = 0, lineCount = 0;

#undef yywrap
%}

/* definitions */
word [^ \t\n]+
eol  \n

/* rules section */
%%
{word} { wordCount++; charCount += yyleng; }
{eol}  { charCount++; lineCount++; }
.        charCount++;
%%

/* user subroutines section */

char **fileList;
unsigned int currentFile = 0;
unsigned int nFiles = 0;
unsigned long totalCC = 0; // total char count
unsigned long totalWC = 0; // total word count
unsigned long totalLC = 0; // total line count

int main(int argc, char **argv)
{
  FILE *file;

  fileList = argv + 1;
  nFiles = argc - 1;

  if (argc == 2) {
    currentFile = 1;
    file = fopen(argv[1], "r");
    if (!file) {
      fprintf(stderr, "could not open %s\n", argv[1]);
      exit(1);
    }
    yyin = file;
  }

  if (argc > 2) {
    yywrap(); /* open first file */
  }

  yylex();

  if (argc > 2) {
    printf("%8u %8u %8u %s\n", charCount, wordCount, lineCount, fileList[currentFile - 1]);
    totalCC += charCount;
    totalWC += wordCount;
    totalLC += lineCount;
    printf("%8lu %8lu %8lu total\n", totalCC, totalWC, totalLC);
  } else {
    printf("%d %d %d\n", charCount, wordCount, lineCount);
  }

  return 0;
}

int yywrap() {
  FILE *file = NULL;

  if ((currentFile != 0) && (nFiles > 1) && (currentFile < nFiles)) {
    printf("%8u %8u %8u %s\n", charCount, wordCount, lineCount, fileList[currentFile - 1]);
    totalCC += charCount;
    totalWC += wordCount;
    totalLC += lineCount;
    charCount = wordCount = lineCount = 0;
    fclose(yyin);
  }

  while (fileList[currentFile] != (char *)0) {
    file = fopen(fileList[currentFile++], "r");
    if (file != NULL) {
      yyin = file;
      break;
    }
    fprintf(stderr, "could not open %s\n", fileList[currentFile - 1]);
  }

  return (file ? 0 : 1); /* 0 means there's no more input */
}

