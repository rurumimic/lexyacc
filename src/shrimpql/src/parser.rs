pub mod ast;

use lalrpop_util::lalrpop_mod;

lalrpop_mod!(pub sql, "/parser/sql.rs");
