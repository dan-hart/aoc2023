//
//  main.swift
//  AdventOfCode2023
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import aoc2023core

let challenge = Day01()

let input = challenge.loadInput()

print("\(challenge.name):")
challenge.run(with: input)

print(":done")
_ = readLine()

