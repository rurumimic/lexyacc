use anyhow::Result;
use shrimpql::lexer::Lexer;
use shrimpql::parser::sql::QueryParser;

fn main() -> Result<()> {
    let source = "SELECT a, b AS bee FROM my_table AS t WHERE a = 1 AND b = 'ok';";

    let lexer = Lexer::new(source);
    let parser = QueryParser::new();
    let ast = parser.parse(lexer).unwrap();

    println!("{:?}", ast);

    Ok(())
}
