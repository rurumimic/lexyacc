all: build

build: parser lexer build_pgm

parser: parser.y
	yacc -v -d parser.y
	# yacc -dt parser.y; # debug mode
	cp y.tab.c parser.c
	cp y.tab.h parser.h
	cp y.output parser.output

lexer: lexer.l parser.h
	flex lexer.l
	cp lex.yy.c lexer.c

build_pgm: lexer.c parser.c
	# separate compilation:
	# gcc -g -c parser.c
	# gcc -g -c lexer.c
	# gcc -g -o sql.pgm lexer.o parser.o -ll -lfl -lc
	# or use: -ll (instead of -ly)
	# gcc -g -o sql.pgm lexer.c parser.c -ll -lfl -lc
	# or use: -ly (instead of -ll)
	gcc -g -o sql.pgm lexer.c parser.c -ly -lfl -lc
	# -ly is for yacc
	# -ll is for yacc
	# -lfl is for flex
	# -lc is for stdio.h

clean:
	rm -f *.pgm *.o *.output lexer.c parser.c parser.h y.tab.c y.tab.h lex.yy.c

