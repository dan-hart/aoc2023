//
//  File.swift
//
//
//  Created by Dan Hart on 12/7/23.
//

import Foundation

public class Day07: Challenge {
    public var name: String = "Day 7"
    public init() {}
    
    public enum Card: Int, CaseIterable {
        case A = 14
        case K = 13
        case Q = 12
        case J = 11
        case T = 10
        case c9 = 9
        case c8 = 8
        case c7 = 7
        case c6 = 6
        case c5 = 5
        case c4 = 4
        case c3 = 3
        case c2 = 2
        
        public init(from: String) {
            switch from {
            case "A": self = .A
            case "K": self = .K
            case "Q": self = .Q
            case "J": self = .J
            case "T": self = .T
            case "9": self = .c9
            case "8": self = .c8
            case "7": self = .c7
            case "6": self = .c6
            case "5": self = .c5
            case "4": self = .c4
            case "3": self = .c3
            case "2": self = .c2
            default: fatalError("Invalid card string")
            }
        }
    }
    
    public enum HandType: Int, CaseIterable {
        case fiveOfAKind = 7
        case fourOfAKind = 6
        case fullHouse = 5
        case threeOfAKind = 4
        case twoPair = 3
        case onePair = 2
        case highCard = 1
    }
    
    public struct Hand: Hashable, Equatable, Comparable {
        public static func < (lhs: Day07.Hand, rhs: Day07.Hand) -> Bool {
            if lhs.type.rawValue < rhs.type.rawValue {
                return true
            }
            if lhs.type.rawValue == rhs.type.rawValue {
                for (lhsIndex, lhsCard) in lhs.cards.enumerated() {
                    if lhsCard.rawValue < rhs.cards[lhsIndex].rawValue {
                        return true
                    }
                }
                return false
            }
            if lhs.type.rawValue > rhs.type.rawValue {
                return false
            }
            
            return false
        }
        
        var cards: [Card]
        var bid: Int
        
        public init(cards: [Card], bid: Int) {
            self.cards = cards
            self.bid = bid
        }
        
        public init(line: String) {
            let components = line.components(separatedBy: " ")
            self.bid = Int(components.last!)!
            self.cards = components.first!.split(separator: "").map({ char in
                Card(from: String(char))
            })
        }
        
        public var type: HandType {
            let grouped = Dictionary(grouping: cards, by: { $0 })
            if grouped.count == 1 { return .fiveOfAKind }
            if grouped.count == 2 {
                if grouped.values.contains(where: { $0.count == 4 }) { return .fourOfAKind }
                if grouped.values.contains(where: { $0.count == 3 }) { return .fullHouse }
            }
            if grouped.count == 3 {
                if grouped.values.contains(where: { $0.count == 3 }) { return .threeOfAKind }
                if grouped.values.contains(where: { $0.count == 2 }) { return .twoPair }
            }
            if grouped.count == 4 {
                if grouped.values.contains(where: { $0.count == 2 }) { return .onePair }
            }
            return .highCard
        }
    }
    
    public func run(with input: [String], also rawInput: String) {
        let hands = input.map { line in
            Hand(line: line)
        }
        print("Result: \(hands.scorePart01())")
    }
}

extension Array where Element == Day07.Hand {
    public func scorePart01() -> Int {
        let sorted = self.sorted { lhs, rhs in
            return lhs < rhs
        }
        var winnings = [Int]()
        for rank in 0..<sorted.count {
            winnings.append(sorted[rank].bid * rank + 1)
        }
        return winnings.reduce(0, +)
    }
}
