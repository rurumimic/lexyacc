all:
	yacc -d parser.y;
	# yacc -dt parser.y; # debug mode
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;

	flex lexer.l;
	cp lex.yy.c lexer.c;

	gcc -g -o mgl.pgm lexer.c parser.c subr.c -ll -lfl -lc;
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
	# -lc is for stdio.h
clean:
	rm -f first.c first mgl.pgm *.o lexer.c parser.c parser.h
