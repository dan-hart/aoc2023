//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation

public protocol Challenge {
    var name: String { get set }
    func run(with input: [String], also rawInput: String)
}

public extension Challenge {
    func loadInputLines() -> [String] {
        return try! String(contentsOfFile: ("~/input.txt" as NSString).expandingTildeInPath)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }
    
    func loadRawInput() -> String {
        return try! String(contentsOfFile: ("~/input.txt" as NSString).expandingTildeInPath)
    }
}
