//
//  Day08Tests.swift
//  AdventOfCode2023Tests
//
//  Created by Dan Hart on 12/8/23.
//

import Foundation
import XCTest
@testable import aoc2023core

final class Day08Tests: XCTestCase {
    let example01 = """
    RL
    
    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let example02 = """
    LLR
    
    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """
    
    func testParsing() {
        let day = Day08()
        
        let map01 = day.parseToMap(from: example01.components(separatedBy: "\n"))
        XCTAssertEqual(map01.instructions, ["R", "L"])
        XCTAssertEqual(map01.nodes.count, 7)
        
        let map02 = day.parseToMap(from: example02.components(separatedBy: "\n"))
        XCTAssertEqual(map02.instructions, ["L", "L", "R"])
        XCTAssertEqual(map02.nodes.count, 3)
    }
    
    func testStepCount() {
        let day = Day08()
        
        let map01 = day.parseToMap(from: example01.components(separatedBy: "\n"))
        XCTAssertEqual(map01.calculateSteps(from: "AAA", to: "ZZZ"), 2)
        
        let map02 = day.parseToMap(from: example02.components(separatedBy: "\n"))
        XCTAssertEqual(map02.calculateSteps(from: "AAA", to: "ZZZ"), 6)
    }
    
    let example03 = """
    LR
    
    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testStepCountPart02() {
        let day = Day08()
        let map = day.parseToMap(from: example03.components(separatedBy: "\n"))
        XCTAssertEqual(map.calculateSteps(), 6)
    }
}
