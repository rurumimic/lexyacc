# Book

- book: [lex & yacc, 2nd](https://learning.oreilly.com/library/view/lex-yacc/9781565920002/)
- src: [lex yacc, 2nd](https://resources.oreilly.com/examples/9781565920002)

## Contents

1. lex & yacc
   - [grammar](src/grammar/README.md)
2. lex
   - [regex](src/regex/README.md)
   - [wordcount](src/wordcount/README.md)
   - [command line](src/command_line/README.md)
   - [c analyzer](src/c_analyzer/README.md)
3. yacc
  - [calculator](src/calculator/README.md)
4. [menu generation language](src/menu_generation_language/README.md)

## Clone the Source Code

```bash
git clone https://resources.oreilly.com/examples/9781565920002.git
mv 9781565920002 lexyacc
cd lexyacc
```

### Build a File

```bash
flex ch1-01.l
mv lex.yy.c ch1-01.c
gcc -g -o ch1-01.pgm ch1-01.c -lfl -ll
```

#### Run the File

```bash
./ch1-01.pgm

hello
hello
bye
bye
^D
```

### Build the Project

Change `-ly -ll` to `-lfl -ll` in the Makefile:

```makefile
# make and run all the example programs for lex & yacc, Second Edition
CC = gcc -g
# LIBS = -ly -ll
LIBS = -lfl -ll
LEX = flex
YACC = yacc
CFLAGS = -DYYDEBUG=1
```

Build:

```bash
make
```

