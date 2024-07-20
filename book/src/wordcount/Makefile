all:
	flex wc.l;
	gcc -g -o wc.pgm lex.yy.c -ll -lfl;
clean:
	rm -f *.c *.h *.o *.pgm;

