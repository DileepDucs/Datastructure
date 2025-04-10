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
    
    /**
     Given a number N, The task is to find the length of the longest consecutive 1s series in its binary representation.
     Examples :
     Input: N = 14
     Output: 3
     Explanation: The binary representation of 14 is 1110.


     Input: N = 222
     Output: 4
     Explanation: The binary representation of 222 is 11011110.
     */
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
