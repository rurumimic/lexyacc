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

```bash
flex ch1-05.l;
cp lex.yy.c ch1-05l.c;

yacc -d ch1-05.y;
cp y.tab.c ch1-05y.c;
cp y.tab.h ch1-05y.h;

gcc -g -c ch1-05l.c -o ch1-05l.o;
gcc -g -c ch1-05y.c -o ch1-05y.o;
gcc -g -o ch1-05.pgm ch1-05l.o ch1-05y.o -lfl -ll;
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

