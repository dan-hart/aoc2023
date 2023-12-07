//
//  Day07Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/7/23.
//

import XCTest
@testable import aoc2023core

final class Day07Tests: XCTestCase {
    func testHandType() {
        XCTAssertEqual(Day07.Hand(line: "AAAAA 1").type, Day07.HandType.fiveOfAKind)
        XCTAssertEqual(Day07.Hand(line: "AA8AA 1").type, Day07.HandType.fourOfAKind)
        XCTAssertEqual(Day07.Hand(line: "23332 1").type, Day07.HandType.fullHouse)
        XCTAssertEqual(Day07.Hand(line: "TTT98 1").type, Day07.HandType.threeOfAKind)
        XCTAssertEqual(Day07.Hand(line: "23432 1").type, Day07.HandType.twoPair)
        XCTAssertEqual(Day07.Hand(line: "A23A4 1").type, Day07.HandType.onePair)
        XCTAssertEqual(Day07.Hand(line: "23456 1").type, Day07.HandType.highCard)
    }
    
    func testHandComparison() {
        XCTAssertTrue(Day07.Hand(line: "AAAAA 1") > Day07.Hand(line: "AA8AA 1"))
        XCTAssertTrue(Day07.Hand(line: "33332 1") > Day07.Hand(line: "2AAAA 1"))
        XCTAssertTrue(Day07.Hand(line: "77888 1") > Day07.Hand(line: "77788 1"))
    }
    
    func testExample() {
        let input = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """
        let hands = input.components(separatedBy: "\n").map { Day07.Hand(line: $0) }
        XCTAssertEqual(hands.scorePart01(), 6440)
    }
}
