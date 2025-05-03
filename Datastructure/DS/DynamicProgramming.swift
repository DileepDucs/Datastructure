//
//  DynamicProgramming.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 25/02/25.
//
import Foundation

/*
 🧠 What is Dynamic Programming?
 Dynamic Programming (DP) is a method for solving complex problems by breaking them down into simpler subproblems. It solves each subproblem once and stores the result to avoid redundant work. It’s ideal when a problem has:

 Optimal Substructure: A problem can be broken down into subproblems which can be solved optimally.
 Overlapping Subproblems: The same subproblems recur multiple times.
 
 🧩 Approaches to Dynamic Programming
 //MARK: Memoization (Top-Down)
 Recursive + caching results
 Easy to write but can be slower due to stack overhead
 Tabulation (Bottom-Up)
 Iterative + fills DP table
 Often faster and avoids recursion
 Space Optimization
 When only the last few states are needed, reduce space from O(n) to O(1) or O(2)
 */
class DynamicProgramming {
    
    // Longest Common Subsequence
    // https://www.youtube.com/watch?v=NnD96abizww // this explanation match with
    //We use Dynamic Programming (DP) to efficiently solve the problem.
    
    /*  Time Complexity: O(m×n), where m and n are the lengths of text1 and text2.
        Space Complexity: O(m×n) due to the DP table.
     */
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let m = text1.count
        let n = text2.count
        // converted string into array for easy traversal in swift
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        
        // Create a DP table initialized with zeros
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        
        // Fill DP table... row [0][i] and column [j][0] are fillup with 0 by default so loop start from i = 1 and j = 1
        for i in 1...m {
            for j in 1...n {
                if text1Array[i - 1] == text2Array[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]  // Characters match
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) // Take max from previous values
                }
            }
        }
        return dp[m][n]
    }
    
    /**
     Backtracking to Find the Actual LCS
     Once we have the dp table, we can trace back to construct the LCS.
     */
    
    func findLCS(_ text1: String, _ text2: String) -> String {
        var m = text1.count
        var n = text2.count
        // converted string into array for easy traversal in swift
        let text1Array = Array(text1)
        let text2Array = Array(text2)
        var lcs = ""
        // Create a DP table initialized with zeros
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        
        // Fill DP table... row [0][i] and column [j][0] are fillup with 0 by default so loop start from i = 1 and j = 1
        for i in 1...m {
            for j in 1...n {
                if text1Array[i - 1] == text2Array[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]  // Characters match
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) // Take max from previous values
                }
            }
        }
        // Till here, it is coppied as the longestCommonSubsequence code
        
        
        // Backtrack through the DP table
        while m > 0 && n > 0 {
            if text1Array[m - 1] == text2Array[n - 1] {
                lcs.append(text1Array[m - 1]) // Add matching character to LCS
                m -= 1
                n -= 1
            } else if dp[m - 1][n] > dp[m][n - 1] {
                m -= 1  // Move up
            } else {
                n -= 1  // Move left
            }
        }
        return String(lcs.reversed())
    }
    
    // same as above but here array of integer
    //Longest common subarray in the given two arrays
    //We use Dynamic Programming (DP) to efficiently solve the problem.
    //https://leetcode.com/problems/maximum-length-of-repeated-subarray/description/
    //https://www.youtube.com/watch?v=m4AOIKV3b9Y
    func findLengthOptimum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        let m = nums2.count
        var result = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
        var max = 0
        for i in 1...n {
            for j in 1...m {
                if nums1[i - 1] == nums2[j - 1] {
                    result[i][j] = 1 + result[i - 1][j - 1]
                }
            }
        }
        
        for i in 0...n {
            var string = ""
            for j in 0...m {
                string = string + " " + "\(result[i][j])"
                if result[i][j] > max {
                    max = result[i][j]
                }
            }
            print(string)
        }
        return max
    }
    
}

/**
 
 func possibleRect(_ A : [Int], _ B : [Int]) -> Int{
     var maxResult = 0
     var rectangles = [(Int, Int)]()
     let n = A.count
     var dict = [Int: [(Int, Int)]]()
     for i in 0..<n {
         let width = min(A[i], B[i])
         let height = max(A[i], B[i])
         rectangles.append((width, height))
     }
     
     for value in rectangles {
         let width = value.0
         let height = value.1
         if dict[width] == nil {
             dict[width] = []
         }
         if dict[height] == nil {
             dict[height] = []
         }
         if width == height {
             dict[width]?.append(value)
         } else {
             dict[width]?.append((width, height))
             dict[height]?.append((height, width))
         }
     }
     
     for (_, values) in dict {
         let temp = getResultCount(array: values)
         maxResult = max(maxResult, temp)
     }
     return maxResult
 }
 
 func getResultCount(array: [(Int, Int)]) -> Int {
     var maxFrequency = 0
     var dict = [Int : Int]()
     var resultKey = 0
     var result = 0
     for (a, b) in array {
         if let value = dict[b] {
             dict[b] = value + 1
         } else {
             dict[b] = 1
         }
     }
     for (key, value) in dict {
         if value > maxFrequency {
             maxFrequency = value
             resultKey = key
         }
     }
     for (a, b) in array {
         if b == resultKey || b - 1 == resultKey || b + 1 == resultKey {
             result = result + 1
         }
     }
     return result
 }
 
 
 
 public func solution(_ B : [String]) -> Int {
 // All possible direction down, left and right
     let possibleDirection = [(1, 0), (0,  -1), (0, 1)]

     // converting array of string into 2d array
     var cave = [[Character]]()
     for caveString in B {
         let array = Array(caveString)
         cave.append(array)
     }
     let n = cave.count // total row in 2d array
     let m = cave[0].count // total column in 2d array

     // check if expedition is possible into a cave
     guard cave[0][0] == "." && cave[n-1][m - 1] == "." else {
         return -1
     }
     var maxPossibleWay = 0
     var visitedPath = Set<[Int]>()
         
         // DFS traversal to travers all possible position in cave
     func dfsTraversal(row: Int, column: Int, possibleCount: Int) {
         if row == n - 1 && column == m - 1 {
             maxPossibleWay = max(maxPossibleWay, possibleCount)
             return
         }
             
         visitedPath.insert([row, column])
             
         for (r, c) in possibleDirection {
             let newRow = row + r
             let newColumn = column + c
             if newRow >= 0, newRow < n, newColumn >= 0, newColumn < m, cave[newRow][newColumn] == ".", !visitedPath.contains([newRow, newColumn]) {
                 dfsTraversal(row: newRow, column: newColumn, possibleCount: possibleCount + 1)
                 }
             }
             visitedPath.remove([row, column])
             
         }
     // Start DFS from (0,0)
     dfsTraversal(row: 0, column: 0, possibleCount: 0)

     return maxPossibleWay
 }
 
 
 
 
 
 
 
 
 func exicuteArray() {
     //let array = ArrayDS()
     //let value = array.subarraySum([1, 1, 1], 2)
     //let value = array.maximumSubarraySum([8,5,20,2,9], 1)
     //print(value)
     //print(array.binaryGap(9))
     //let graphData = GraphDataStructure()
     //graphData.testingGraph()
     //let value = graphData.solution([2, 3, 2, 3, 5],  [3, 4, 2, 4, 2])
     
     let tree = Tree()
     //tree.problems()
 }
 */

