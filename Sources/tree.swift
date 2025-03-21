
/// In the original C files, these methods are in the module tree and the node is define in defs,
/// I feel that I can encapsulate everything inside the class

// Abstract Syntax Tree Structure
class ASTnode {
    var operation: NodeType // "Operation" to be performed on this tree
    var left: ASTnode?      // Left and right child trees
    var right: ASTnode?
    var int_value: Int
    
    init(operation: NodeType, left: ASTnode? = nil, right: ASTnode? = nil, int_value: Int) {
        self.operation = operation
        self.left = left
        self.right = right
        self.int_value = int_value
    }
    
    /// Build and return a generic AST node
    static func mkastnode(operation: NodeType, left: ASTnode? = nil, right: ASTnode? = nil, int_value: Int ) -> ASTnode {
        
        return ASTnode(operation: operation, left: left, right: right, int_value: int_value)
    }
    
    /// Make an AST leaf node
    static func mkastleaf(operation: NodeType, int_value: Int) -> ASTnode {
        return ASTnode(operation: operation, int_value: int_value)
    }
    
    /// make a unary AST node: only one child
    static func mkastunary(operation: NodeType, left: ASTnode, int_value: Int) -> ASTnode {
        return ASTnode(operation: operation, left: left, int_value: int_value)
    }

}

