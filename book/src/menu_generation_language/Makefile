all:
	yacc -d parser.y;
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;

	flex lexer.l;
	cp lex.yy.c lexer.c;

	gcc -g -o subr.o -c subr.c
	gcc -g -o parser.o -c parser.c
	gcc -g -o lexer.o -c lexer.c
	gcc -g -o mgl.pgm lexer.o parser.o subr.o -ll -lfl -lc;
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
	# -lc is for stdio.h

