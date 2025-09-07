#[derive(Clone, Debug, PartialEq)]
pub enum Query {
    Select(Select),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Select {
    pub columns: Vec<SelectItem>,
    pub from: TableRef,
    pub r#where: Option<Expr>,
}

#[derive(Clone, Debug, PartialEq)]
pub enum SelectItem {
    Wildcard,
    Column { name: Ident, alias: Option<String> },
}

#[derive(Clone, Debug, PartialEq)]
pub struct TableRef {
    pub name: Ident,
    pub alias: Option<String>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Ident(pub Vec<String>);

#[derive(Clone, Debug, PartialEq)]
pub enum Expr {
    Ident(Ident),
    Integer(i64),
    String(String),
    BinaryOp { lhs: Box<Expr>, op: BinOp, rhs: Box<Expr> },
}

#[derive(Clone, Debug, PartialEq)]
pub enum BinOp {
    Eq,
    And,
    Or,
}
