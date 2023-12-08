//
//  File.swift
//  
//
//  Created by Dan Hart on 12/8/23.
//

import Foundation

public enum Math {
    /// Finds the Greatest Common Factor (GCF) of two integers using the Euclidean Algorithm.
    ///
    /// The Greatest Common Factor (GCF), also known as the Greatest Common Divisor (GCD), is a mathematical
    /// concept that refers to the largest positive integer that divides two or more numbers without leaving a remainder.
    ///
    /// - Parameters:
    ///        - x: The first integer.
    ///        - y: The second integer.
    ///
    /// - Returns: The greatest common factor of the two input integers. If either input is zero, the absolute value of the non-zero input is returned. If both inputs are zero, zero is returned.
    public static func greatestCommonFactor(_ x: Int, _ y: Int) -> Int {
        // Ensure non-negative values for the inputs
        var a = 0
        var b = max(x, y)
        var r = min(x, y)
        
        // Apply the Euclidean Algorithm to find the GCF
        while r != 0 {
            a = b
            b = r
            
            // Update variables for the next iteration
            r = a % b
        }
        
        return b
    }
    
    /// Calculates the Least Common Multiple (LCM) of two integers.
    ///
    /// The Least Common Multiple (LCM) is a mathematical concept that refers to the smallest positive integer that is divisible
    /// by two or more numbers without leaving a remainder. It is also known as the Lowest Common Multiple or Smallest Common
    /// Multiple.
    ///
    /// - Parameters:
    ///        - a: The first integer.
    ///        - b: The second integer.
    ///
    /// - Returns: The least common multiple of the two input integers. If either input is zero, the LCM is considered zero. If both inputs are zero, zero is returned.
    public static func leastCommonMultiple(for a: Int, and b: Int) -> Int {
        a / greatestCommonFactor(a, b) * b
    }
    
    /// Finds the Least Common Multiple (LCM) for an array of integers.
    ///
    ///    The Least Common Multiple (LCM) is a mathematical concept that refers to the smallest positive integer that is divisible
    /// by two or more numbers without leaving a remainder. It is also known as the Lowest Common Multiple or Smallest Common
    /// Multiple.
    
    /// - Parameters:
    ///     - values: An array of integers for which the LCM needs to be calculated.
    ///
    /// - Returns: The least common multiple of the input integers. If the array has fewer than two unique values, the first unique value is returned. If the array is empty, 0 is returned.
    public static func leastCommonMultiple(for values: [Int]) -> Int {
        let uniqueValues = Array(Set(values))
        
        guard uniqueValues.count >= 2 else {
            return uniqueValues.first ?? 0
        }
        
        // Initialize the current LCM with the LCM of the first two unique values
        var currentLcm = leastCommonMultiple(for: uniqueValues[0], and: uniqueValues[1])
        
        // Iterate through the remaining unique values in the array and update the current LCM
        for value in uniqueValues[2 ..< uniqueValues.count] {
            currentLcm = leastCommonMultiple(for: currentLcm, and: value)
        }
        
        return currentLcm
    }
}
