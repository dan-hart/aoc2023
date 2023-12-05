//
//  Day03Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/3/23.
//

import XCTest
@testable import aoc2023core

final class Day03Tests: XCTestCase {    
    func testExample02() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
        let lines = input.components(separatedBy: .newlines)
        let map = Day03().convertToCharacterMap(from: lines)
        let total = Day03().sumPartNumbers(with: map)
        XCTAssertEqual(total, 467835)
    }
}
