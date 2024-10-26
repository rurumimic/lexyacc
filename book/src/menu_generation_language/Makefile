all: build menu

build: parser lexer build_mgl

parser: parser.y
	yacc -d parser.y
	# yacc -dt parser.y; # debug mode
	cp y.tab.c parser.c
	cp y.tab.h parser.h

lexer: lexer.l parser.h
	flex lexer.l
	cp lex.yy.c lexer.c

build_mgl: lexer.c parser.c subr.c
	gcc -g -o mgl.pgm lexer.c parser.c subr.c -ll -lfl -lc
	# -ll is for yacc
	# -lfl is for flex
	# -lm is for math.h
	# -lc is for stdio.h

menu: mgl.pgm mgl-input
	./mgl.pgm mgl-input
	cat example_main.c >> menu.c
	gcc -o menu.pgm menu.c -lcurses -ltermcap

clean:
	rm -f *.pgm *.o lexer.c parser.c parser.h y.tab.c y.tab.h lex.yy.c menu.c

