//
//  Array.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 30/12/24.
//

import Foundation

class Array {
    
    // find max element from array
    func max(array: [Int]) -> Int {
        var max = Int.min
        for value in array {
            if value > max {
                max = value
            }
        }
        return max
    }
    
    // find min element from array
    func min(array: [Int]) -> Int {
        var min = Int.max
        for value in array {
            if value < min {
                min = value
            }
        }
        return min
    }
    
    //second largest element from unsorted array
    
    func secondLargestNumber(array: [Int]) -> Int? {
        if array.count < 2 {
            print("Second largest not possible")
            return nil
        }
        var max = Int.min
        var secondMax = Int.min
        for value in array {
            if value > max {
                secondMax = max
                max = value
            } else if value > secondMax && value != max {
                secondMax = value
            }
        }
        return secondMax
    }
}


