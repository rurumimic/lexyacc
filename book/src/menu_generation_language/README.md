# Menu Generation Language

## Build

```bash
cd first_version
make
```

## Run

```bash
./mgl.pgm mgl-input
```

### screen.out

```bash
cp screen.out first.c
```

Add main:

```bash
tee -a first.c <<EOF

void main() {
  menu_second();
  menu_cleanup();
}

EOF
```

```bash
gcc -o first.pgm first.c -lcurses -ltermcap
```

### Run Menu

```bash
./first
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

