//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation

public protocol Challenge {
    var name: String { get set }
    func run(with input: [String])
}

public extension Challenge {
    func loadInput() -> [String] {
        return try! String(contentsOfFile: ("~/Desktop/input.txt" as NSString).expandingTildeInPath)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }
}
