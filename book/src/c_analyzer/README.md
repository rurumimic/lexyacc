# C Source Code Analyzer

## Build

```bash
make
```

## Run

```bash
cat example | tee /dev/tty | ./c_analyzer.pgm
```

```c
#include <stdio.h> /* header */

/* This is
 * a main function
 */

/* return type */ int main() {
  printf("Hello, World!");
  return 0;
}

```

```bash
code: 5, comments 3, whitespace 3
```

