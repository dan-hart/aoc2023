//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import Parsing
import RegexBuilder

class Day02: Challenge {
    var name: String = "\(Day02.self)"
    
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
    }
    
    public struct Day02Game: Codable {
        var number: Int
        var sets: [Day02Set]
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
    
    func run(with input: [String]) {
    }
}
