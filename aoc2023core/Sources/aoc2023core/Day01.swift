//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import RegexBuilder

public class Day01: Challenge {    
    public var name: String = "\(Day01.self)"
    
    public init() {}
    
    public func run(with input: [String], also rawInput: String) {
        let digits = input.map { line in
            let number = convertToNumber(using: "\(line)")
            return number
        }

        let sum = digits.reduce(0, +)
        print("result: \(sum)")
    }
    
    let digitWords = [
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
    ]

    public func convertToNumber(using line: String) -> Int {
        let number = Reference(Substring.self)
        let regex = Regex {
            Capture(as: number) {
                ChoiceOf {
                    ("1"..."9")
                    "one"
                    "two"
                    "three"
                    "four"
                    "five"
                    "six"
                    "seven"
                    "eight"
                    "nine"
                }
            }
        }
        .ignoresCase()
        
        var correctedLine = line
        for word in digitWords {
            guard let firstLetter = word.first, let lastLetter = word.last else {
                continue
            }
            correctedLine = correctedLine.replacingOccurrences(of: word, with: "\(firstLetter)\(word)\(lastLetter)")
        }
        
        let numbersWithWords = correctedLine.matches(of: regex).map { match in
            "\(match[number])"
        }
        var values = [String]()
        for digitOrWord in numbersWithWords {
            switch digitOrWord {
            case "one": values.append("1")
            case "two": values.append("2")
            case "three": values.append("3")
            case "four": values.append("4")
            case "five": values.append("5")
            case "six": values.append("6")
            case "seven": values.append("7")
            case "eight": values.append("8")
            case "nine": values.append("9")
            default: values.append(digitOrWord)
            }
        }
        if let first = Int(values.first ?? "0"), let last = Int(values.last ?? "0") {
            return (first * 10) + last
        } else {
            print("Could not find first and last value in \(values)")
            return 0
        }
    }
}
