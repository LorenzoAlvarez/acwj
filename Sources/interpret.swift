/// Given an AST, interpret the operators
/// in it and return a final value

func interpretAST(node: ASTnode) -> Int {
    // Get the left and right sub-trees values
    var leftval: Int = 0
    var rightval: Int = 0
    if node.left != nil {
        leftval = interpretAST(node: node.left!)
    }
    if node.right != nil {
        rightval = interpretAST(node: node.right!)
    }
    
    // Debug: Print what we are about to do
    if node.operation == .A_INTLIT {
        print("int \(node.int_value)")
    } else {
        print("\(leftval) \(node.operation) \(rightval)")
    }
    
    switch node.operation {
    case .A_ADD:
        return leftval+rightval
    case .A_SUBTRACT:
        return leftval-rightval
    case .A_MULTIPLY:
        return leftval*rightval
    case .A_DIVIDE:
        return Int(leftval/rightval)
    case .A_INTLIT:
        return node.int_value
    default:
        print("Unknown AST operator \(node.operation)")
    }
}
