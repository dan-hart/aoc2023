//
//  File.swift
//  
//
//  Created by Dan Hart on 12/4/23.
//

import Foundation
import Parsing

public struct Day04Card: Hashable {
    var cardNumber: Int
    var winningNumbers: [Int]
    var selectedNumbers: [Int]
    
    var countOfWinningNumbers: Int {
        var count = 0
        for selectedNumber in selectedNumbers where winningNumbers.contains(selectedNumber) {
            count += 1
        }
        return count
    }
    
    var points: Int {
        if countOfWinningNumbers == 0 { return 0 }
        var totalPoints = 1
        for _ in 1..<countOfWinningNumbers {
            totalPoints *= 2
        }
        return totalPoints
    }
    
    var copyCount = 1
}

public class Day04: Challenge {
    public var name: String = "\(Day04.self)"
    public init() {}
    
    /// Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    public func parseCard(_ line: String) -> Day04Card {
        let tripleSpacesRemoved = line.replacingOccurrences(of: "   ", with: " ")
        let doubleSpacesRemoved = tripleSpacesRemoved.replacingOccurrences(of: "  ", with: " ")
        let parser = Parse {
            "Card "
            Int.parser()
            ": "
            Many {
                Int.parser()
                " "
            }
            "| "
            Prefix { $0 != "\n" }
        }
            .map { output in
                let selectedNumbers = String(output.2).components(separatedBy: " ").map({Int($0) ?? 0})
                return Day04Card(cardNumber: output.0, winningNumbers: output.1, selectedNumbers: selectedNumbers)
            }
        
        do {
            let card = try parser.parse(doubleSpacesRemoved)
            return card
        } catch {
            print(error)
            return Day04Card(cardNumber: -1, winningNumbers: [], selectedNumbers: [])
        }
    }

    public func calculateInstanceCount(for cards: inout [Day04Card]) {
        for i in 0..<cards.count {
            let card = cards[i]
            let winningCount = card.countOfWinningNumbers
            if winningCount > 0 {
                for _ in 0..<card.copyCount {
                    for j in 1...winningCount {
                        cards[i + j].copyCount += 1
                    }
                }
            }
        }
    }
    
    public func run(with input: [String], also rawInput: String) {
        var cards = input.map { line in
            parseCard(line)
        }
        calculateInstanceCount(for: &cards)
        print(cards.totalInstanceCount)
    }
}

extension Array where Element == Day04Card {
    public var totalPoints: Int {
        var total = 0
        for card in self {
            total += card.points
        }
        return total
    }
    
    public var totalInstanceCount: Int {
        var total = 0
        for card in self {
            total += card.copyCount
        }
        return total
    }
}
