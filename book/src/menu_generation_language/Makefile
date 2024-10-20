all:
	flex lexer.l;
	cp lex.yy.c lexer.c;
	yacc -d parser.y;
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;
	gcc -g mgl mgl.c mgl-code.c;
	gcc -g -o mgl.pgm lexer.c parser.c mgl -ll -lfl -lc;
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
	# -lc is for stdio.h
clean:
	rm -f *.c *.h *.o *.pgm;

