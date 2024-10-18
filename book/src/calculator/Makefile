all:
	flex lexer.l;
	cp lex.yy.c lexer.c;
	yacc -d parser.y;
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;
	gcc -g -o calculator.pgm lexer.c parser.c -ll -lfl -lm;
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
clean:
	rm -f *.c *.h *.o *.pgm;

