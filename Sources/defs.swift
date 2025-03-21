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
    case T_EOF
    
    static func get_symbol(type: TokenType) -> String {
        switch type {
        case .T_PLUS:
            return "+"
        case .T_MINUS:
            return "-"
        case .T_STAR:
            return "*"
        case .T_SLASH:
            return "/"
        case .T_INTLIT:
            return "intlit"
        default:
            return "unknown"
        }
    }
}

// Token structures
struct Token {
    var type: TokenType
    var int_value: Int
}

// AST node types
enum NodeType {
    case A_ADD
    case A_SUBTRACT
    case A_MULTIPLY
    case A_DIVIDE
    case A_INTLIT
    
    static func artihop(token_type: TokenType) throws -> NodeType {
        switch token_type {
        case TokenType.T_PLUS:
            return .A_ADD
        case TokenType.T_MINUS:
            return .A_SUBTRACT
        case TokenType.T_STAR:
            return .A_MULTIPLY
        case TokenType.T_SLASH:
            return .A_DIVIDE
        default:
            print("Unknown token in arithop()")
            throw fatalError()
        }
    }
}


