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
        
        public func calculateSteps(for key: String) -> Int {
            var nodeKey = key
            var stepCount = 0
            var instructionIndex = 0
            while nodeKey.last != "Z" {
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
            let currentKeys: Set<String> = Set(nodes.filter({ $0.key.last == "A" }).map({ $0.key }))
            let results = currentKeys.map { key in
                calculateSteps(for: key)
            }
            return Math.leastCommonMultiple(for: results)
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
