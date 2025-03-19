// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


@available(macOS 10.15.4, *)
private func scanfile(scanner: inout Scanner) {
    let tokstr = [
        TokenType.T_PLUS: "+",
        TokenType.T_MINUS: "-",
        TokenType.T_STAR: "*",
        TokenType.T_SLASH: "/",
        TokenType.T_INTLIT: "intlit"
    ]
    
    var token = Token(type: TokenType.T_UNKNOWN, int_value: 0)
    
    while  scanner.scan(token: &token) != 0 {
        print("Token \(tokstr[token.type] ?? "unknown")", terminator: "")
        if token.type == TokenType.T_INTLIT {
            print(", value \(token.int_value)", terminator: "")
        }
        print()
    }
    
}

let arguments = CommandLine.arguments

if arguments.count != 2 {
    print("No file filled")
    exit(-1)
}

var scanner = Scanner(file_path: arguments[1])
scanfile(scanner: &scanner)
