//
//  File.swift
//  
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import Parsing

class Day02: Challenge {
    var name: String = "\(Day02.self)"
    
    public enum Day02CubeColor: String, CaseIterable, Codable, Hashable {
        case red = "Red"
        case green = "Green"
        case blue = "Blue"
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
    
    func run(with input: [String]) {
        let games: [Day02Game?] = input.map { line in
            let game = Parse {
                
            }
        }
    }
}
