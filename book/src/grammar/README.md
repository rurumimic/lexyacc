# Grammar

## Build

```bash
make
```

## Run

```bash
./grammar.pgm
```

input grammar:

```bash
noun cat mouse apple
verb chases eats
pron he
conj and but
prep with in on
adj big small
adv slowly
```

test grammar:

```bash
cat chases mouse.

Parsed a simple sentence.
```

```bash
big cat chases small mouse with apple.

Parsed a simple sentence.
```

```bash
he slowly eats apple.

Parsed a simple sentence.
```

```bash
small cat chases mouse with apple and he slowly eats apple.

Parsed a compound sentence.
```

