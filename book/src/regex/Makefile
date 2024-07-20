all:
	flex regex.l;
	gcc -g -o regex.pgm lex.yy.c -ll -lfl;
clean:
	rm -f *.c *.h *.o *.pgm;

