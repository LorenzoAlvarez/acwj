// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


@available(macOS 10.15.4, *)
private func scanfile(scanner: inout Scanner) {
    var token = Token(type: TokenType.T_UNKNOWN, int_value: 0)
    _ = scanner.scan(token: &token)
    let node = try! binaryexpr(scanner: &scanner, token: &token, ptp: 0)
    print("\(interpretAST(node: node))")
}

let arguments = CommandLine.arguments

if arguments.count != 2 {
    print("No file filled")
    exit(-1)
}

var scanner = Scanner(file_path: arguments[1])
scanfile(scanner: &scanner)
