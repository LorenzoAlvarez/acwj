/// Parse a primary factor and return an AST node representing it
func primary(scanner: inout Scanner, token: inout Token) throws -> ASTnode  {
    // For an INTLIT token, make a leaft AST node for it
    // and scan in the next token, Otherwise, a syntax error
    // for any other token type.

    switch token.type {
        case TokenType.T_INTLIT:
            let n = ASTnode.mkastleaf(operation: NodeType.A_INTLIT, int_value: token.int_value)
            _ = scanner.scan(token: &token)
            return n
        default:
            print("syntax error on line \(scanner._line)")
            throw fatalError()
    }
}

/// Return an AST tree whose root is a binary operator
/// Parapeter ptp is the previous toke's precedence
func binaryexpr(scanner: inout Scanner, token: inout Token, ptp: Int) throws ->  ASTnode {
    
    // Get the integer literal on the left.
    // Fetch the next token at the same time.
    var left = try! primary(scanner: &scanner, token: &token)
    
    // If no tokens left, return just the left node
    var tokentype = token.type
    if tokentype == .T_EOF {
        return left
    }
    
    // While the precedene ofthis token is
    // more than that of the previous token precedence
    while try! TokenType.op_precedence(type: tokentype) > ptp {
        // Fetch in the next integer literal
        scanner.scan(token: &token)
        
        // Recursively call binexpr() with the
        // precedence of our token to build a sub-tree
        let right = try! binaryexpr(scanner: &scanner, token: &token, ptp: TokenType.get_precedence(type: tokentype))
        
        // Join taht sub-tree with ours. Convert the token
        // into an AST operation at the time
        left = ASTnode.mkastnode(operation: try! NodeType.artihop(token_type: tokentype), left: left, right: right, int_value: 0)
        
        // Update the details of the current token.
        // If no tokens left, return just the left node
        tokentype = token.type
        if tokentype == .T_EOF {
            return left
        }
    }
    
    // Return the tree we have when the precedence
    // is the same or lower
    return left
    
}

