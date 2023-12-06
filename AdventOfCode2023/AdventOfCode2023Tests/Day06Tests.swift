//
//  Day06Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/6/23.
//

import XCTest
@testable import aoc2023core

final class Day06Tests: XCTestCase {
    func testExample() {
        let input = """
        times: 7 15 30
        distances: 9 40 200
        """
        let lines = input.components(separatedBy: "\n")
        let races = Day06().parseToRaces(from: lines)
        XCTAssertEqual(races.count, 3)
        XCTAssertEqual(races.first!.winningButtonDurations().count, 4)
        XCTAssertEqual(races[1].winningButtonDurations().count, 8)
        XCTAssertEqual(races.last!.winningButtonDurations().count, 9)
        XCTAssertEqual(races.winningButtonDurationsMultiplied, 288)
    }
    
    func testPart02() {
        let input = """
        times: 7 15 30
        distances: 9 40 200
        """
        let lines = input.components(separatedBy: "\n")
        let race = Day06().part02parseToRaces(from: lines)
        XCTAssertEqual(race.winningButtonDurations().count, 71503)
    }
}
