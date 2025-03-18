//
//  defs.swift
//  acwj
//
//  
//

// Tokens
enum TokenType {
    case T_PLUS
    case T_MINUS
    case T_STAR
    case T_SLASH
    case T_INTLIT
    case T_UNKNOWN
}

// Token structures
struct Token {
    var type: TokenType
    var int_value: Int
}
