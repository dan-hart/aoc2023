//
//  Day02Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/2/23.
//

import XCTest
@testable import aoc2023core

final class Day02Tests: XCTestCase {
    func testGameParser() {
        let challenge = Day02()
        let gamesInput = """
        Game 46: 1 blue, 11 red, 6 green; 2 blue, 11 red, 6 green; 8 red, 5 green
        Game 47: 2 blue, 9 red; 1 green, 5 blue; 10 red, 2 blue, 2 green; 10 red, 3 green, 3 blue; 3 red, 6 blue, 2 green; 1 red, 1 green, 5 blue
        Game 48: 1 red, 7 green; 1 blue, 10 green, 5 red; 4 red, 8 green; 10 red, 10 green; 2 red, 16 green; 11 red, 14 green, 1 blue
        """
        let games = gamesInput.components(separatedBy: "\n")
        
        let firstGame = challenge.parseToGame(from: games.first ?? "")
        XCTAssertEqual(firstGame?.number, 46)
        XCTAssertEqual(firstGame?.sets.first?.cubes.first?.count, 1)
        XCTAssertEqual(firstGame?.sets.first?.cubes.first?.color.rawValue, "Blue")
    }
}
