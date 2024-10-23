all:
	yacc -d parser.y;
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;

	flex lexer.l;
	cp lex.yy.c lexer.c;

	gcc -g -o subr.o subr.c parser.h subr.h;
	# gcc -g -o mgl.pgm lexer.c parser.c subr -ll -lfl -lc;
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
	# -lc is for stdio.h

