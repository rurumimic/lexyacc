all:
	flex lexer.l;
	cp lex.yy.c lexer.c;
	yacc -d parser.y;
	cp y.tab.c parser.c;
	cp y.tab.h parser.h;
	gcc -g -o grammer.pgm lexer.c parser.c -ll -lfl;
clean:
	rm -f *.c *.h *.o *.pgm;

