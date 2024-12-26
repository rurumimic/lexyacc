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
5. sql
   - [sql](src/sql/README.md)
   - [embedded sql](src/embedded_sql/README.md)

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

---

## Tip

### Debugging

```bash
yacc -v -d parser.y

yacc: 1 rule never reduced
yacc: 1 shift/reduce conflict, 20 reduce/reduce conflicts.
```

Open `y.output` to see the conflicts:

```bash
188: shift/reduce conflict (shift 190, reduce 157) on UNION
state 188
	query_exp : query_exp . UNION query_term  (154)
	query_exp : query_exp . UNION ALL query_term  (155)
	query_term : '(' query_exp .  (157)

	UNION  shift 190
	DECLARE  reduce 157
	ORDER  reduce 157
	PROCEDURE  reduce 157
	';'  reduce 157
```

