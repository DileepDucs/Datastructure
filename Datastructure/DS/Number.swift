//
//  Number.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 11/02/25.
//

import Foundation

class Number {
    //Binary Gap (Find the longest sequence of 0s in binary representation)
    //https://www.geeksforgeeks.org/length-longest-consecutive-1s-binary-representation/
    func toBinaryArray(_ num: Int) -> [Int] {
        var num = num
        var binaryArray: [Int] = []
        while num > 0 {
            binaryArray.append(num % 2) // Get the last bit
            num /= 2 // Divide number by 2
        }
        
        return binaryArray.reversed() // Reverse to get correct order
    }
}
