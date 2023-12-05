//
//  main.swift
//  AdventOfCode2023
//
//  Created by Dan Hart on 12/2/23.
//

import Foundation
import aoc2023core

let challenge = Day05()

let input = challenge.loadInputLines()
let rawInput = challenge.loadRawInput()

print("\(challenge.name):")
challenge.run(with: input, also: rawInput)

print(":done")
_ = readLine()

