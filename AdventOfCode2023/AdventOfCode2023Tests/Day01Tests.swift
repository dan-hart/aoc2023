//
//  Day01Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/2/23.
//

import XCTest
@testable import aoc2023core

final class Day01Tests: XCTestCase {
    func testDay() {
        let challenge = Day01()
        XCTAssertEqual(challenge.name, "Day01")
    }
    
    func testEdgeCases() {
        let challenge = Day01()
        XCTAssertEqual(challenge.convertToNumber(using: "35zrgthreetwonesz"), 31)
        XCTAssertEqual(challenge.convertToNumber(using: "85eightpqeightwojmh"), 82)
        XCTAssertEqual(challenge.convertToNumber(using: "6oneeightwod"), 62)
        XCTAssertEqual(challenge.convertToNumber(using: "8ninefivegzk7ftqbceightwogfv"), 82)
    }
}
