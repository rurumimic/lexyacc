# ShrimpQL

## Init

### Dependencies

```bash
cargo add --build lalrpop
cargo add lalrpop-util -F lexer -F unicode
cargo add logos
```

### build.rs

- [build.rs](build.rs)

```rust
fn main() {
    lalrpop::process_root().unwrap();
}
```

### src/lib.rs

```rust
pub mod parser;
```

### src/parser.rs

1. add `.lalrpop` file in `src/parser/` folder
2. write the following code in `src/parser.rs`

```rust
use lalrpop_util::lalrpop_mod;

lalrpop_mod!(pub calculator, "/parser/calculator.rs");
```

