//
//  File.swift
//  
//
//  Created by Dan Hart on 12/6/23.
//

import Foundation

public class Day06: Challenge {
    public var name: String = "Day 6"
    public init() {}
    
    public struct Race: Hashable {
        var seconds: Int
        var meters: Int
        
        public func winningButtonDurations() -> [Int] {
            var durations = [Int]()
            for duration in 1..<seconds {
                let metersPerSecond = duration
                let metersTraveled = metersPerSecond * (seconds - duration)
                if metersTraveled > meters {
                    durations.append(duration)
                }
            }
            return durations
        }
    }
    
    /// Time:      7  15   30
    /// Distance:  9  40  200
    public func parseToRaces(from input: [String]) -> [Day06.Race] {
        let times = input.first!.split(separator: " ").dropFirst().map { Int($0)! }
        let distances = input.last!.split(separator: " ").dropFirst().map { Int($0)! }
        return zip(times, distances).map { Day06.Race(seconds: $0.0, meters: $0.1) }
    }
    
    /// Time:      7  15   30
    /// Distance:  9  40  200
    public func part02parseToRaces(from input: [String]) -> Day06.Race {
        let time = Int(input.first!.split(separator: " ").dropFirst().map { String($0) }.filter({$0.isEmpty == false}).joined())!
        let distance = Int(input.last!.split(separator: " ").dropFirst().map { String($0) }.filter({$0.isEmpty == false}).joined())!
        return Day06.Race(seconds: time, meters: distance)
    }
    
    public func run(with input: [String], also rawInput: String) {
        // Part 01
//        let races = Day06().parseToRaces(from: input)
//        print(races.winningButtonDurationsMultiplied)
        
        // Part 02
        let race = Day06().part02parseToRaces(from: input)
        print(race.winningButtonDurations().count)
    }
}

extension Array where Element == Day06.Race {
    public var winningButtonDurationsMultiplied: Int {
        return self.map { $0.winningButtonDurations().count }.reduce(1, *)
    }
}
