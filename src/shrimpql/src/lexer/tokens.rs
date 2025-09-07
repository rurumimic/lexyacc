use logos::Logos;
use std::fmt; // to implement the Display trait
use std::num::ParseIntError;

#[derive(Default, Debug, Clone, PartialEq)]
pub enum LexicalError {
    InvalidInteger(ParseIntError),
    InvalidString,
    #[default]
    InvalidToken,
}

impl From<ParseIntError> for LexicalError {
    fn from(err: ParseIntError) -> Self {
        LexicalError::InvalidInteger(err)
    }
}

fn parse_string(lex: &mut logos::Lexer<Token>) -> Result<String, LexicalError> {
    let s = lex.slice();
    // Expecting single-quoted string, with '' as escape for '
    if s.len() >= 2 {
        let inner = &s[1..s.len() - 1];
        let unescaped = inner.replace("''", "'");
        Ok(unescaped)
    } else {
        Err(LexicalError::InvalidString)
    }
}

#[derive(Logos, Clone, Debug, PartialEq)]
#[logos(skip r"[ \t\n\r]+", skip r"--[^\n]*\n?", error = LexicalError)]
pub enum Token {
    // Keywords (case-insensitive)
    #[token("SELECT", ignore(ascii_case))]
    KeywordSelect,
    #[token("FROM", ignore(ascii_case))]
    KeywordFrom,
    #[token("WHERE", ignore(ascii_case))]
    KeywordWhere,
    #[token("AS", ignore(ascii_case))]
    KeywordAs,
    #[token("AND", ignore(ascii_case))]
    KeywordAnd,
    #[token("OR", ignore(ascii_case))]
    KeywordOr,

    // Identifiers and literals
    #[regex(r"[A-Za-z_][A-Za-z0-9_]*", |lex| lex.slice().to_string())]
    Identifier(String),
    #[regex(r"[0-9]+", |lex| lex.slice().parse())]
    Integer(i64),
    #[regex(r"'([^']|'')*'", |lex| parse_string(lex))]
    String(String),

    // Punctuation
    #[token("(")]
    LParen,
    #[token(")")]
    RParen,
    #[token(",")]
    Comma,
    #[token(".")]
    Dot,
    #[token("*")]
    Star,
    #[token("=")]
    Eq,
    #[token(";")]
    Semicolon,
}

impl fmt::Display for Token {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{self:?}")
    }
}
