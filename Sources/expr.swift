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
func binaryexpr(scanner: inout Scanner, token: inout Token) throws ->  ASTnode {
    
    // Get the integer literal on the left
    // Fetch the next token at the same time.
    
    let left = try! primary(scanner: &scanner, token: &token)
    
    // If no token left, retun just the left node
    if token.type == TokenType.T_EOF {
        return left
    }
    // Convert the token into a node type
    
    let nodetype = try! NodeType.artihop(token_type: token.type)
    
    // Get the next token in
    _ = scanner.scan(token: &token)
    
    // Recursively get the right-hand tree
    let right = try! binaryexpr(scanner: &scanner, token: &token)
    
    return ASTnode.mkastnode(operation: nodetype, left:left, right: right, int_value: 0)
    
}

