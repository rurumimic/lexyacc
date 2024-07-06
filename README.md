# lex & yacc

## Book

- book: [lex & yacc, 2nd](https://learning.oreilly.com/library/view/lex-yacc/9781565920002/)
- src: [lex yacc, 2nd](https://resources.oreilly.com/examples/9781565920002)

Clone the source code:

```bash
git clone https://resources.oreilly.com/examples/9781565920002.git
mv 9781565920002 lexyacc
cd lexyacc
```

### Install Packages

```bash
sudo apt install yacc flex
```

### Build a File

```bash
flex ch1-01.l
mv lex.yy.c ch1-01.c
gcc -g -o ch1-01.pgm ch1-01.c -lfl -ll
```

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
# make and run all the example programs for
# lex & yacc, Second Edition
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

