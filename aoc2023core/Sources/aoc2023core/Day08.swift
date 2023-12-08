//
//  File.swift
//  
//
//  Created by Dan Hart on 12/8/23.
//

import Foundation

public class Day08: Challenge {
    public var name: String = "Day 8"
    public init() {}
    
    public struct Map: Hashable {
        let instructions: [String]
        let nodes: [Node]
        
        public func calculateSteps(from startKey: String, to endKey: String) -> Int {
            var nodeKey = startKey
            var stepCount = 0
            var instructionIndex = 0
            while nodeKey != endKey {
                let instruction = instructions[instructionIndex]
                let node = nodes.first(where: { $0.key == nodeKey })!
                
                switch instruction.uppercased() {
                case "R":
                    nodeKey = node.rightKey
                case "L":
                    nodeKey = node.leftKey
                default: break
                }
                
                if instructionIndex == instructions.count - 1 {
                    instructionIndex = 0
                } else {
                    instructionIndex += 1
                }
                
                stepCount += 1
            }
            return stepCount
        }
        
        // Part 02
        public func calculateSteps() -> Int {
            let keysThatEndInA = nodes.filter({ $0.key.last == "A" }).map({ $0.key })
            
            var currentKeys = keysThatEndInA
            var stepCount = 0
            var instructionIndex = 0
            while currentKeys.filter({ $0.last == "Z" }).count != currentKeys.count {
                if currentKeys.filter({ $0.last == "Z" }).count > 1 {
                    // format step count with commas
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .decimal
                    let stepCountString = formatter.string(from: NSNumber(value: stepCount))!
                    print("stepCount: \(stepCountString)")
                    print("zCount: \(currentKeys.filter({ $0.last == "Z" }).count) of total \(currentKeys.count)")
                }
                
                let instruction = instructions[instructionIndex]
                let nodes = self.nodes.filter({ currentKeys.contains($0.key) })
                
                switch instruction.uppercased() {
                case "R":
                    currentKeys = nodes.map({ $0.rightKey })
                case "L":
                    currentKeys = nodes.map({ $0.leftKey })
                default: break
                }
                
                if instructionIndex == instructions.count - 1 {
                    instructionIndex = 0
                } else {
                    instructionIndex += 1
                }
                
                stepCount += 1
            }
            return stepCount
        }
    }
    
    public struct Node: Hashable {
        let key: String
        
        let leftKey: String
        let rightKey: String
    }
    
    public enum Key: String, CaseIterable {
        case startKey = "AAA"
        case endKey = "ZZZ"
    }
    
    public func parseToMap(from lines: [String]) -> Map {
        let instructions = lines.first?.map({ letter in
            String(letter)
        }) ?? []
        let nodeLines = lines.dropFirst(2)
        let nodes = nodeLines.map { line -> Node in
            let keyLeftRight = line
                .replacingOccurrences(of: "=", with: "")
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: ",", with: "")
                .components(separatedBy: " ").filter({$0.isEmpty == false})
            return Node(key: keyLeftRight[0], leftKey: keyLeftRight[1], rightKey: keyLeftRight[2])
        }
        return Map(instructions: instructions, nodes: nodes)
    }
    
    public func run(with input: [String], also rawInput: String) {
        let map = parseToMap(from: input)
        print("Part 01: \(map.calculateSteps(from: "AAA", to: "ZZZ"))")
        print("Part 02: \(map.calculateSteps())")
    }
}
