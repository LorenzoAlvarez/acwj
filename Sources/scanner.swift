//
//  scanner.swift
//  acwj
//
//

import Foundation

@available(macOS 10.15.4, *)
struct Scanner {
    // properties
    var _line: Int = 1
    var _putback: Character = "\0"
    var _in_file: FileHandle
    
    init(file_path: String) {
        if let fileHandle = FileHandle(forReadingAtPath: file_path) {
            _in_file = fileHandle
        }
        else {
            // Handle error if file can't be opened
            print("Error: Could not open file")
            exit(0)
        }
    }
    
    // public
    
    /**
     Scan and return the next token found in the input.
     Return 1 if token valed, 0 if no token left..
     */
    public mutating func scan(token: inout Token) -> Int {
        // Skip whitespace
        var c = skip()
        
        switch c {
        case "\0":
            token.type = TokenType.T_EOF
            return 0
        case "+":
            token.type = TokenType.T_PLUS
        case "-":
            token.type = TokenType.T_MINUS
        case "*":
            token.type = TokenType.T_STAR
        case "/":
            token.type = TokenType.T_SLASH
        default:
            // If it's a digit, scan the literal integer value in
            if c.isNumber {
                token.int_value = scanint(c: &c)
                token.type = TokenType.T_INTLIT
                print(token.int_value)
            }
            else {
                print("Unrecognised character \(c) on line \(_line)")
            }
        }
        return 1
    }
    
    // private
    
    /**
                Get the next character from the input file
     */
    private mutating func next() -> Character {
        if _putback != "\0" {
            let c = _putback
            _putback = "\0"
            return c
        }
        
        guard let data = try? _in_file.read(upToCount: 1), let byte = data.first else {
            return "\0" // Return nil if no data is available
        }
        let c = Character(UnicodeScalar(byte))
        if c == "\n" {
            _line += 1
        }
        
        return c
    }
    
    /**
                Put a character back into the input stream
     */
    private mutating func putback(c: Character) {
        _putback = c
    }
    
    /**
     Read and silently skips whitespace characters unti it gets a non-whitespace character
     
     Skip past input that we don't need to deal with,
     Return the first character we do need to deal with
     */
    private mutating func skip() -> Character {
        var c = next()
        while c.isWhitespace {
            c = next()
        }
        return c
    }
    
    /**
     Scan and return an integer literal value from the input file
     */
    private mutating func scanint(c: inout Character) -> Int {
        var val: Int = 0
        while let digit = c.wholeNumberValue {
            val = val * 10 + digit
            c = next()
        }
        // We hit a non-integer character, put it back
        putback(c: c)
        return val
    }
    

}
