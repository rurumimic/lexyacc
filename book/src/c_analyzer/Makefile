all:
	flex c_analyzer.l;
	gcc -g -o c_analyzer.pgm lex.yy.c -ll -lfl;
clean:
	rm -f *.c *.h *.o *.pgm;

