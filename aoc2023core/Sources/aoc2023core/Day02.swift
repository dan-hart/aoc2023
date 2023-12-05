//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import Parsing
import RegexBuilder

public class Day02: Challenge {
    public var name: String = "\(Day02.self)"
    
    public init() {}
    
    public enum Day02CubeColor: String, CaseIterable, Codable, Hashable {
        case red = "Red"
        case green = "Green"
        case blue = "Blue"
        
        static func parseFrom(rawValue: String?) -> Day02CubeColor? {
            switch rawValue?.lowercased() {
            case "red": return .red
            case "green": return .green
            case "blue": return .blue
            default: return nil
            }
        }
    }
    
    public struct Day02Set: Codable {
        var cubes: [Day02Cube]
        
        public func total(forColor: Day02CubeColor) -> Int {
            var total = 0
            for cube in cubes {
                if cube.color == forColor {
                    total += cube.count
                }
            }
            return total
        }
        
        public func isPossible(forRedCount: Int, forGreenCount: Int, forBlueCount: Int) -> Bool {
            let redTotal = total(forColor: .red)
            let greenTotal = total(forColor: .green)
            let blueTotal = total(forColor: .blue)
            
            let isSetPossible = (redTotal <= forRedCount && greenTotal <= forGreenCount && blueTotal <= forBlueCount)
            return isSetPossible
        }
    }
    
    public struct Day02Game: Codable {
        var number: Int
        var sets: [Day02Set]
        
        public func total(forColor: Day02CubeColor) -> Int {
            var total = 0
            for set in sets {
                for cube in set.cubes {
                    if cube.color == forColor {
                        total += cube.count
                    }
                }
            }
            return total
        }
        
        // Part 1: Is game possible
        var isPossible: Bool {
            var localIsPossible = true
            for set in sets {
                if set.isPossible(forRedCount: 12, forGreenCount: 13, forBlueCount: 14) == false {
                    localIsPossible = false
                }
            }
            return localIsPossible
        }
        
        public func getMinimum(forColor: Day02CubeColor) -> Int {
            var minimum = Int.max
            for set in sets {
                for cube in set.cubes where cube.color == forColor {
                    if cube.count < minimum {
                        minimum = cube.count
                    }
                }
            }
            return minimum
        }
        
        public func getMaximum(forColor: Day02CubeColor) -> Int {
            var maximum = Int.min
            for set in sets {
                for cube in set.cubes where cube.color == forColor {
                    if cube.count > maximum {
                        maximum = cube.count
                    }
                }
            }
            return maximum
        }
        
        // Part 2: Minimum number of cubes
        func getMinimumPossibleForValidGame() -> (Day02Cube, Day02Cube, Day02Cube)? {
            let minimumRed = getMaximum(forColor: .red)
            let minimumGreen = getMaximum(forColor: .green)
            let minimumBlue = getMaximum(forColor: .blue)
            
            return (Day02Cube(color: .red, count: minimumRed), Day02Cube(color: .green, count: minimumGreen), Day02Cube(color: .blue, count: minimumBlue))
        }
        
        func getPowerFromMinimumPossibleForValidGame() -> Int {
            guard let cubes = getMinimumPossibleForValidGame() else { return 0 }
            return cubes.0.count * cubes.1.count * cubes.2.count
        }
    }
    
    public struct Day02Cube: Codable {
        var color: Day02CubeColor
        var count: Int
    }
    
    // Game 1: 12 blue; 2 green, 13 blue, 19 red; 13 red, 3 green, 14 blue
    public func parseToGame(from line: String) -> Day02Game? {
        guard let gameNumberSetsRegex = try? Regex("^Game\\s(?<GameNumber>\\d+):\\s(?<Sets>.*$)") else { return nil }
        let matches = line.matches(of: gameNumberSetsRegex)
        guard let gameNumber = Int(matches.first?.output[1].substring ?? "0") else { return nil }
        guard let sets = matches.last?.output[2].substring else { return nil }
        let setLines = sets.split(separator: ";")
        var setObjects = [Day02Set]()
        for setLine in setLines {
            var cubeObjects = [Day02Cube]()
            let cubes = setLine.split(separator: ",")
            for cube in cubes {
                let numberAndColor = cube.trimmingPrefix(" ").split(separator: " ")
                guard let number = Int(numberAndColor.first ?? "0") else { return nil }
                guard let color = Day02CubeColor.parseFrom(rawValue: String(numberAndColor.last ?? "")) else { return nil }
                cubeObjects.append(Day02Cube(color: color, count: number))
            }
            
            setObjects.append(Day02Set(cubes: cubeObjects))
        }
        return Day02Game(number: gameNumber, sets: setObjects)
    }
    
    public func run(with input: [String], also rawInput: String) {
        let games = input.map { line in
            parseToGame(from: line)
        }
        
        var total = 0
        var powerTotal = 0
        for game in games {
            if game?.isPossible ?? false {
                guard let gameNumber = game?.number else {
                    print("Game number not found")
                    continue
                }
                total += gameNumber
            }
            powerTotal += game?.getPowerFromMinimumPossibleForValidGame() ?? 0
        }
        
        print("part 01 total: \(total)")
        print("part 02 total: \(powerTotal)")
    }
}
