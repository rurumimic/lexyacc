# Menu Generation Language

## Build

```bash
make clean
make
```

### Manual Build

```bash
make build
./mgl.pgm mgl-input
cat example_main.c >> menu.c
gcc -o menu.pgm menu.c -lcurses -ltermcap
```

### Run Menu

```bash
./menu.pgm
```

```bash
Second

1) other menu
```

```bash
First

1) dummy line
2) run shell
3) exit program
```

