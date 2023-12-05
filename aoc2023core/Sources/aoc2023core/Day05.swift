//
//  File.swift
//  
//
//  Created by Dan Hart on 12/5/23.
//

import Foundation
import Parsing
import AsyncAlgorithms
import Collections

public struct Day05Almanac: Hashable, Equatable {
    public let initialSeedNumbers: [Int]
    public let lookups: [Day05Lookup]
    
    public func initialSeedNumberRanges() async -> AsyncMapSequence<AsyncChunksOfCountSequence<AsyncSyncSequence<[Int]>, [AsyncSyncSequence<[Int]>.Element]>, Range<AsyncSyncSequence<[Int]>.Element>> {
        initialSeedNumbers.async.chunks(ofCount: 2).map { $0.first!..<($0.first! + $0.last!) }
    }
    
    public func convert(sourceNumber: Int) -> Int {
        var value = sourceNumber
        for lookup in lookups {
            value = lookup.convert(sourceNumber: value)
        }
        return value
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
}

public struct Day05SeedPair: Hashable, Equatable {
    public let sourceNumber: Int
    public let length: Int
}

public struct Day05Range: Hashable, Equatable {
    public let destinationRangeStart: Int
    public let sourceRangeStart: Int
    public let rangeLength: Int
    
    public var sourceRangeEnd: Int {
        sourceRangeStart + rangeLength
    }
    
    public func isInRange(sourceNumber: Int) -> Bool {
        return (sourceRangeStart...sourceRangeEnd).contains(sourceNumber)
    }
    
    public func convert(sourceNumber: Int) -> Int {
        let adjustment = sourceNumber - sourceRangeStart
        let calculatedDestination = destinationRangeStart + adjustment
        return calculatedDestination
    }
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
        return Day05Almanac(initialSeedNumbers: parsedLine1Numbers, lookups: lookups)
    }

    public func run(with input: [String], also rawInput: String) {
        guard let almanac = convertToAlmanac(from: input, also: rawInput) else { return }
        
        Task {
            let asyncLocations = await withTaskGroup(of: [Int].self) { group in
                let ranges = await almanac.initialSeedNumberRanges()
                for await range in ranges {
                    group.addTask {
                        range.compactMap { number in
                            almanac.convert(sourceNumber: number)
                        }
                    }
                }
                
                var results = [Int]()
                for await list in group {
                    results.append(contentsOf: list)
                }
                return results
            }
            
            // Get minimum
            let minimum = asyncLocations.min() ?? 0
            print("Minimum: \(minimum)")
        }
    }
}
