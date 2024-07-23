all:
	flex command_line.l;
	gcc -g -o command_line.pgm lex.yy.c -ll -lfl;
clean:
	rm -f *.c *.h *.o *.pgm;

