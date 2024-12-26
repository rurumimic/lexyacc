# Embedded SQL

## Build

```bash
make clean
make
```
### Run SQL Parser

- input: [embedded.sql](embedded.sql)
- output: [embedded.c](embedded.c)

```bash
./sql.pgm embedded.sql | sed '$d' | tee embedded.c
```

```c
char flavor[6], name[8], type[5];
int SQLCODE; /* global status variable */

exec_sql(" DECLARE flav CURSOR FOR  SELECT Foods.name, Foods.\
type  FROM Foods  WHERE Foods.flavor =  #1", &flavor);


void main(void) {
  scanf("%s", flavor);
  exec_sql(" OPEN flav");

  for(;;) {
    exec_sql(" FETCH flav INTO  #1,  #2", &name, &type);

    if(SQLCODE != 0) {
      break;
    }
    printf("%8.8s %5.5s\n", name, type);
  }
  exec_sql(" CLOSE flav");

}
```

```bash
Embedded SQL parse worked
```

