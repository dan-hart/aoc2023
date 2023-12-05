//
//  File.swift
//  
//
//  Created by Dan Hart on 12/5/23.
//

import Foundation
import Parsing

public struct Day05Almanac: Hashable {
    public let initialSeedNumbers: [Int]
    public let lookups: [Day05Lookup]
    
    public let pairs: [Day05SeedPair]
    
    public func convert(sourceNumber: Int) -> Int {
        var value = sourceNumber
        for lookup in lookups {
            value = lookup.convert(sourceNumber: value)
        }
        
        return value
    }
    
//    public func printDebugDescription() {
//        print("Almanac: seed numbers: \(initialSeedNumbers.map({"\($0), "})), Lookups:")
//        for lookup in lookups {
//            lookup.printDebugDescription()
//        }
//    }
}

public struct Day05SeedPair: Hashable {
    public let sourceNumber: Int
    public let length: Int
    public let values: ContiguousArray<Int>
    
    init(sourceNumber: Int, length: Int) {
        self.sourceNumber = sourceNumber
        self.length = length
        self.values = ContiguousArray(sourceNumber..<(sourceNumber + length))
    }
}

public struct Day05Lookup: Hashable {
    public let ranges: [Day05Range]
    
    public func convert(sourceNumber: Int) -> Int {
        let foundRange: Day05Range? = ranges.first { range in
            range.isInRange(sourceNumber: sourceNumber)
        }
        
        return foundRange?.convert(sourceNumber: sourceNumber) ?? sourceNumber
    }
    
//    public func printDebugDescription() {
//        print("\n\tLookup: \(ranges.count) ranges:")
//        for range in ranges {
//            range.printDebugDescription()
//        }
//    }
}

public struct Day05Range: Hashable {
    public let destinationRangeStart: Int
    public let sourceRangeStart: Int
    public let rangeLength: Int
    
    public var sourceRangeEnd: Int {
        sourceRangeStart + rangeLength
    }
    
    public func isInRange(sourceNumber: Int) -> Bool {
        if sourceNumber >= sourceRangeStart, sourceNumber <= sourceRangeEnd {
            return true
        } else {
            return false
        }
    }
    
    public func convert(sourceNumber: Int) -> Int {
        let adjustment = sourceNumber - sourceRangeStart
        let calculatedDestination = destinationRangeStart + adjustment
        return calculatedDestination
    }
    
//    public func printDebugDescription() {
//        print("\n\t\tRange: \(sourceRangeStart) -> \(destinationRangeStart) for \(rangeLength)")
//    }
}

public class Day05: Challenge {
    public var name: String = "\(Day05.self)"
    public init() {}
    
    public func convertToAlmanac(from lines: [String], also rawInput: String) -> Day05Almanac? {
        let parsedLine1Numbers = (lines.first?.components(separatedBy: " ").map({Int($0) ?? -1}) ?? []).filter({$0 != -1})
        let chunks = rawInput.components(separatedBy: "\n\n").dropFirst()
        let lookups = chunks.map { chunk in
            let ranges = chunk.components(separatedBy: "\n").dropFirst().map { rangeLine in
                let numbers = rangeLine.components(separatedBy: " ").map({Int($0) ?? -1}).filter({$0 != -1})
                return Day05Range(destinationRangeStart: numbers[0], sourceRangeStart: numbers[1], rangeLength: numbers[2])
            }
            return Day05Lookup(ranges: ranges)
        }
        // pair initial seed numbers into the pair objects
        let pairs = stride(from: 0, to: parsedLine1Numbers.count - 1, by: 2).map {
            Day05SeedPair(sourceNumber: parsedLine1Numbers[$0], length: parsedLine1Numbers[$0+1])
        }
        return Day05Almanac(initialSeedNumbers: parsedLine1Numbers, lookups: lookups, pairs: pairs)
    }

    public func run(with input: [String], also rawInput: String) {
        guard let almanac = convertToAlmanac(from: input, also: rawInput) else { return }
        
        var results = [Int]()
        for pair in almanac.pairs {
            for value in pair.values {
                results.append(almanac.convert(sourceNumber: value))
            }
        }
        print(results.min() ?? -1)
    }
}