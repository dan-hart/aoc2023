//
//  Day05Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/5/23.
//

import XCTest
@testable import aoc2023core

final class Day05Tests: XCTestCase {
    func testExample() {
        let input = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """
        let lines = input.components(separatedBy: "\n")
        guard let almanac = Day05().convertToAlmanac(from: lines, also: input) else { return }
        XCTAssertEqual(almanac.initialSeedNumbers, [79, 14, 55, 13])
        XCTAssertEqual(almanac.lookups.count, 7)
        var results = [Int]()
        for pair in almanac.pairs {
            for i in 0..<pair.length {
                let seedNumber = pair.sourceNumber + i
                results.append(almanac.convert(sourceNumber: seedNumber))
            }
        }
        // Find lowest result
        let lowestResult = results.min() ?? -1
        print("Lowest result: \(lowestResult)")
        XCTAssertEqual(lowestResult, 46)
    }
}
