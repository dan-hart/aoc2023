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
        
        case T = 10
        case c9 = 9
        case c8 = 8
        case c7 = 7
        case c6 = 6
        case c5 = 5
        case c4 = 4
        case c3 = 3
        case c2 = 2
        
        // Part 02
        case J = 1
        
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
        
        public var asString: String {
            switch self {
            case .A: return "A"
            case .K: return "K"
            case .Q: return "Q"
            case .J: return "J"
            case .T: return "T"
            case .c9: return "9"
            case .c8: return "8"
            case .c7: return "7"
            case .c6: return "6"
            case .c5: return "5"
            case .c4: return "4"
            case .c3: return "3"
            case .c2: return "2"
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
            if lhs.type.rawValue > rhs.type.rawValue {
                return false
            }
            if lhs.type.rawValue == rhs.type.rawValue {
                for i in 0..<lhs.cards.count {
                    if lhs.cards[i].rawValue == rhs.cards[i].rawValue {
                        continue
                    }
                    if lhs.cards[i].rawValue > rhs.cards[i].rawValue {
                        return false
                    }
                    if lhs.cards[i].rawValue < rhs.cards[i].rawValue {
                        return true
                    }
                }
                return false
            } else {
                return false
            }
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
        
        public func part01Type() -> HandType {
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
        
        public var type: HandType {
            let part01Type = self.part01Type()
            if cards.contains(.J) {
                let grouped = Dictionary(grouping: cards, by: { $0 })
                let jGroup = grouped[.J]!
                switch part01Type {
                case .fiveOfAKind:
                    return .fiveOfAKind
                case .fourOfAKind:
                    if jGroup.count == 1 {
                        return .fiveOfAKind
                    } else {
                        return .fourOfAKind
                    }
                case .fullHouse:
                    return .fiveOfAKind
                case .threeOfAKind:
                    if jGroup.count == 3 {
                        return .fourOfAKind
                    } else if jGroup.count == 2 {
                        return .fiveOfAKind
                    } else {
                        return .fourOfAKind
                    }
                case .twoPair:
                    if jGroup.count == 2 {
                        return .fourOfAKind
                    } else if jGroup.count == 1 {
                        return .fullHouse
                    } else {
                        print("twoPair with jGroup.count \(jGroup.count)")
                    }
                case .onePair:
                    if jGroup.count == 1 {
                        return .threeOfAKind
                    } else if jGroup.count == 2 {
                        return .threeOfAKind
                    } else {
                        print("onePair with jGroup.count \(jGroup.count)")
                    }
                case .highCard:
                    return .onePair
                }
                print("\(part01Type) with jGroup.count \(jGroup.count)")
                return .fiveOfAKind
            } else {
                return part01Type
            }
        }
    }
    
    public func run(with input: [String], also rawInput: String) {
        let hands = input.map { line in
            Hand(line: line)
        }
        print("Result: \(hands.scorePart01())")
        let sortedHands = hands.sorted()
        var i = 0
        for hand in sortedHands {
            let rank = i + 1
            let bid = hand.bid
            let wins = rank * bid
            if hand.cards.contains(.J) {
                print("Hand \(hand.cards.map({$0.asString}).joined()) \(hand.part01Type()) -> (\(hand.type)) ranks \(rank) and bid \(bid). Wins: \(wins)")
            }
            i += 1
        }
    }
}

extension Array where Element == Day07.Hand {
    public func scorePart01() -> Int {
        let sorted = self.sorted()
        var winnings = [Int]()
        var i = 0
        for hand in sorted {
            let rank = i + 1
            let bid = hand.bid
            let wins = rank * bid
            winnings.append(wins)
            
            i += 1
        }
        return winnings.reduce(0, +)
    }
}
