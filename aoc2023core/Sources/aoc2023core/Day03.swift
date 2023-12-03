//
//  File.swift
//
//
//  Created by Dan Hart on 12/3/23.
//

import Foundation

struct Position: Hashable {
    let row: Int
    let column: Int
}

public class Day03: Challenge {
    public var name: String = "Day 3"
    public init() {}
    
    struct EnginePart: Hashable {
        var value: Int
        var isSymbolAdjacent: Bool = false
        var gearPosition: Position?
    }
    
    public func sumPartNumbers(with map: [[Character]]) -> Int {
        var engineParts: [EnginePart] = []
        for (rowIndex, row) in map.enumerated() {
            var buffer = ""
            var isSymbolAdjacent = false
            var gearPosition: Position?
            for (columnIndex, character) in row.enumerated() {
                let position = Position(row: rowIndex, column: columnIndex)
                
                if character.isNumber {
                    buffer.append(character)
                    let elementsAndPositions = map.around(position: position)
                    if gearPosition == nil {
                        for elementsAndPosition in elementsAndPositions where elementsAndPosition.element == "*" {
                            gearPosition = elementsAndPosition.position
                        }
                    }
                    isSymbolAdjacent = isSymbolAdjacent || map.around(position: position)
                        .contains { (element, position) in
                            // Part 1
                            // element != "." && element.isNumber == false
                            // Part 2
                            element == "*"
                        }
                }
                
                if !character.isNumber || columnIndex + 1 == row.count {
                    if !buffer.isEmpty, isSymbolAdjacent {
                        guard let value = Int(buffer) else { continue }
                        engineParts.append(EnginePart(value: value, isSymbolAdjacent: isSymbolAdjacent, gearPosition: gearPosition))
                        isSymbolAdjacent = false
                    }
                    buffer = ""
                    gearPosition = nil
                }
            }
        }
        let symbolAdjacentParts = engineParts.filter({$0.isSymbolAdjacent})
        // Part 02 Group by gear position
        let groupedParts = Dictionary(grouping: symbolAdjacentParts, by: { $0.gearPosition })
        var multipliedTotal = 0
        for pair in groupedParts {
            let position = pair.key ?? Position(row: 0, column: 0)
            let parts = pair.value
            if parts.count != 2 { continue }
            print("for gear at position \(position)")
            let multiplied = Double(parts.first?.value ?? 0) * Double(parts.last?.value ?? 0)
            multipliedTotal += Int(multiplied)
        }
        
        // Part 1
        // return symbolAdjacentParts.map({$0.value}).reduce(0, +)
        // Part 2
        return multipliedTotal
    }
    
    public func convertToCharacterMap(from input: [String]) -> [[Character]] {
        var characterMap = [[Character]]()
        for line in input {
            characterMap.append(line.map { $0 })
        }
        return characterMap
    }
    
    public func run(with input: [String]) {
        let map = Day03().convertToCharacterMap(from: input)
        let total = Day03().sumPartNumbers(with: map)
        print(total)
    }
}

extension RandomAccessCollection {
    subscript(existsAt index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
    func around(position: Position) -> [(element: Element.Element, position: Position)] {
        let row = position.row
        let column = position.column
        let indices: [(row: Int, column: Int)] = [
            (row - 1, column - 1), (row - 1, column), (row - 1, column + 1),
            (row, column - 1), /* this element */ (row, column + 1),
            (row + 1, column - 1), (row + 1, column), (row + 1, column + 1)
        ]
        var foundElements: [(Element.Element, Position)] = []
        for index in indices {
            if let element = self[existsAt: index.row]?[existsAt: index.column] {
                foundElements.append((element, Position(row: index.row, column: index.column)))
            }
        }
        return foundElements
    }
}
