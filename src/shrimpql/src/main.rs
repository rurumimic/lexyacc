use shrimpql::parser::calculator;

fn main() {
    let expr = "(42)";
    match calculator::TermParser::new().parse(expr) {
        Ok(result) => println!("Parsed result: {}", result),
        Err(e) => println!("Error parsing expression: {}", e),
    }
}
