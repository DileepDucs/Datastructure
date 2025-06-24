//
//  ArrayDS.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 30/12/24.
//

import Foundation

class ArrayDS {
    
    /**
     https://leetcode.com/problems/search-in-rotated-sorted-array/submissions/716600320/
     
     In the classic "Search in Rotated Sorted Array" problem:
     ✅ The array is assumed to be originally sorted in increasing order, then rotated.
     ❌ It does not apply directly to arrays sorted in decreasing order — you'd need to modify the logic for that.
     ✅ For Example:
     Increasing order rotated:

     Original:   [1, 2, 3, 4, 5, 6, 7]
     Rotated:    [4, 5, 6, 7, 1, 2, 3]
     This is what the standard binary search algorithm handles.

     ❌ If the array was originally decreasing, like:
     Decreasing order rotated:

     Original:   [9, 8, 7, 6, 5, 4, 3]
     Rotated:    [5, 4, 3, 9, 8, 7, 6]
     You'd need to invert the comparison logic in the binary search algorithm — because the sorted side goes from high → low instead of low → high.

     🧠 In Short:
        Case                                Supported by standard algorithm?                          Notes
     🔼 Increasing + rotated                ✅ Yes (default problem)                         No changes needed
     🔽 Decreasing + rotated              ❌ No                                                      Requires modified logic
     */
    func searchKeyFromSortedRotatedArray(array: [Int], key: Int) -> Int{
        var low = 0
        var high = array.count - 1
        while(low <= high) {
            let mid = (low + high) / 2
            if array[mid] == key {
                return mid
            }
            if array[low] <= array[mid] {
                if array[low] <= key && key <= array[mid] {
                    high = mid - 1
                } else {
                    low = mid + 1
                }
            } else {
                if array[mid] <= key && key <= array[high] {
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
        }
        return -1
    }
    
    //https://leetcode.com/problems/koko-eating-bananas/description/
    /**
     Koko loves bananas. There are piles of bananas, and each pile has a certain number of bananas. Koko can decide her eating speed k (bananas/hour). She has h hours to eat all the bananas.

     Each hour, she chooses one pile and eats up to k bananas from it. If the pile has less than k, she eats all of it and waits for the next hour.

     Goal: Find the minimum integer k such that Koko can eat all the bananas in h hours.
     */
    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var max = Int.min
        for value in piles {
            if value > max {
                max = value
            }
        }
        var left = 1
        var right = max
        while left < right {
            let mid = (left + right) / 2
            if canFinish(piles: piles, h: h, k: mid) {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return left
    }
    
    func canFinish(piles: [Int], h: Int, k: Int) -> Bool {
        var hours = 0
        for pile in piles {
            let value = (pile + k - 1) / k
            hours += value
        }
        return hours <= h
    }
    /**
     This approach is O(n * log m), where n is the number of piles and m is the max pile size."
     */
    
    
    
    //https://leetcode.com/problems/zero-array-transformation-i/description/
        
    func isZeroArray(_ nums: [Int], _ queries: [[Int]]) -> Bool {
        let n = nums.count
        var diff = Array(repeating: 0, count: n + 1)
        
        // Mark difference array
        for query in queries {
            let l = query[0]
            let r = query[1]
            diff[l] += 1
            if r + 1 < n {
                diff[r + 1] -= 1
            }
        }
        
        // Apply prefix sum and compare with nums
        var running = 0
        for i in 0..<n {
            running += diff[i]
            if running < nums[i] {
                return false
            }
        }
        return true
    }
    
    // Find the first non-repeating character in a string (non repeating, nonrepeating)
    
    func firstUniqueChar(_ s: String) -> Character? {
        var dictionary = [Character: Int]()
        for key in s {
            if let value = dictionary[key] {
                dictionary[key] = value + 1
            } else {
                dictionary[key] = 1
            }
        }
        
        for key in s {
            if dictionary[key] == 1 {
                return key
            }
        }
        return nil
    }
    
    /**
     Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the i
     ntervals in the input.
     Example 1:
     Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
     Output: [[1,6],[8,10],[15,18]]
     Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
     
     Example 2:
     Input: intervals = [[1,4],[4,5]]
     Output: [[1,5]]
     Explanation: Intervals [1,4] and [4,5] are considered overlapping.
     https://leetcode.com/problems/merge-intervals/submissions/1554057123/
        
     $0[0] < $1[0]
     This means:
     $0 and $1 are two intervals (e.g., [2,6] and [1,3])
     $0[0] → the start of the first interval
     $1[0] → the start of the second interval
     
     */
    //🔴
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 1 else { return intervals }
        
        // Step 1: Sort the intervals by start time
        let sorted = intervals.sorted { $0[0] < $1[0] }
        
        var result: [[Int]] = [sorted[0]]
        
        // Step 2: Iterate and merge
        for i in 1..<sorted.count {
            guard let last = result.last else { continue }
            let current = sorted[i]
            
            if current[0] <= last[1] {
                // Overlap, so merge
                result[result.count - 1][1] = Swift.max(last[1], current[1])
            } else {
                // No overlap, append
                result.append(current)
            }
        }
        return result
    }
    
    /**
     Binary Gap
     * Problem: Given a positive integer N, find the longest sequence of consecutive zeros that is surrounded by ones in the binary representation of N.
     * Example:
         * Input: 9 (binary 1001) → Output: 2
         * Input: 529 (binary 1000010001) → Output: 4
     */
    public func binaryGap(_ N : Int) -> Int {
        // Implement your solution here
        let binaryArray = convertIntToBinary(number: N)
        var maxGap = 0
        var currentGap = 0
        var counting = false// this is to check if binary is starting from 0  .. EX - 0000101
        for value in binaryArray {
            if value == 1 {
                maxGap = Swift.max(maxGap, currentGap) // Update max gap
                currentGap = 0 // Reset for next sequence
                counting = true
            } else if counting {
                currentGap += 1
            }
        }
        return maxGap
    }
    
    // this is similar problem as above binaryGap with small changes.
    //https://leetcode.com/problems/binary-gap/description/

    // This will return binary number for a given Int value.
    private func convertIntToBinary(number: Int) -> [Int] {
        var number = number
        var array = [Int]()
        while number > 0 {
            let reminder = number % 2
            array.append(reminder)
            number = number / 2
        }
        return array.reversed()

    }
    
    /**
     Frog Jump (FrogRiverOne)
    * Problem: A frog needs to cross a river by stepping on leaves falling at different times. Find the earliest time when the frog can jump to the other side.
    * Example:
        * Input: X = 5, A = [1,3,1,4,2,3,5,4]
        * Output: 6 (earliest time when all positions are covered)
     */
    func earliestTimeToCross(_ X: Int, _ A: [Int]) -> Int {
        var set = Set<Int>()
        for (time, value) in A.enumerated() {
            set.insert(value)
            if set.count == X {
                return time
            }
        }
        return -1
    }
    
    /**
     Tape Equilibrium
    * Problem: Given an array of integers, divide it into two non-empty parts and find the minimum absolute difference of their sums.
    * Example:
        * Input: [3, 1, 2, 4, 3]
        * Output: 1 (splitting at 3 gives [3,1] and [2,4,3] with sums 4 and 9, difference 5)
     */
    
    func tapeEquilibrium(_ A: [Int]) -> Int {
        let totalSum = A.reduce(0, +) // Compute the total sum of the array
        var leftSum = 0
        var minDifference = Int.max
            
        for i in 0..<A.count-1 { // We can split between 1st and last element
            leftSum += A[i] // Add element to left sum
            let rightSum = totalSum - leftSum // Compute right sum
            let difference = abs(leftSum - rightSum) // Calculate absolute difference
            minDifference = Swift.min(minDifference, difference) // Update minDifference
        }
            
        return minDifference
    }
    
    /**
     4. Missing Integer
     * Problem: Given an array of integers, find the smallest positive integer (greater than 0) that does not appear in the array.
     * Example:
         * Input: [1, 3, 6, 4, 1, 2]
         * Output: 5
     */
    
    func missingInteger(_ A: [Int]) -> Int {
        let positiveNumber = Set(A.filter { $0 > 0})
        var start = 1
        while A.contains(start) {
            start += 1
        }
        return start
    }
    
    /**
     5. PermCheck
     * Problem: Check if an array is a permutation of numbers from 1 to N (contains all numbers exactly once).
     * Example:
         * Input: [4, 1, 3, 2]
         * Output: 1 (yes, it's a permutation)
         * Input: [4, 1, 3]
         * Output: 0 (not a permutation)
     */
    public func permCheck(_ A : inout [Int]) -> Int {
        // Implement your solution here
        let n = A.count
        let sum = n * (n + 1) / 2
        let set = Set(A)
        var totalSum = 0
        if set.count != n {
            return 0
        }
        for value in set {
            totalSum += value
        }
        return sum == totalSum ? 1 : 0
    }
    
    /**
     Count Div
     * Problem: Given three integers A, B, and K, find the number of integers in range [A, B] that are divisible by K.
     * Example:
         * Input: A=6, B=11, K=2
         * Output: 3 (Numbers: 6, 8, 10)
     */
    //(O(1) Efficient)
    func countDiv(_ A: Int, _ B: Int, _ K: Int) -> Int {
        return (B / K) - ((A - 1) / K)
    }
    
    //Time Complexity: O(B - A)
    func countDiv2(_ A: Int, _ B: Int, _ K: Int) -> Int {
        var count = 0
        for num in A...B {
            if num % K == 0 {
                count += 1
            }
        }
        return count
    }
    
    /**
     MaxCounters
    * Problem: Simulate a counter array that increases at specific indices or resets to the maximum counter value.
    * Example:
     */
    
    
    /**
     Dominator
     * Problem: Find the dominator in an array (element that appears more than half the times).
     */
    func dominator(array: [Int]) -> Int{
        var dict = [Int: Int]()
        var maxValue = Int.min
        var resultIndex = -1
        for (i, key) in array.enumerated() {
            if let value = dict[key] {
                dict[key] = value + 1
                if value + 1 > maxValue {
                    maxValue = maxValue + 1
                    resultIndex =  i
                }
            } else {
                dict[key] = 1
            }
        }
        return (maxValue > (array.count / 2)) ? resultIndex : -1
    }
    
    /**
     Genomic Range Query
     * Problem: Given a DNA sequence, efficiently answer queries on the minimal nucleotide in a given range.
     * Example:
     */
    
    
    
    /**
     Passing Cars
     * Problem: Count the number of passing car pairs (0 followed by 1) in an array.
     * Example:
         * Input: [0,1,0,1,1]
         * Output: 5
     */
    //https://www.youtube.com/watch?v=9CAbsaaFvSk
    //https://app.codility.com/demo/results/training5NSSN2-F6R/
    public func passigCars(_ A : inout [Int]) -> Int {
        // Implement your solution here
        var rightCars = 0
        var totalPassingCars = 0
        for value in A {
            if value == 0 {
                rightCars += 1
            } else {
                totalPassingCars += rightCars
                if totalPassingCars > 1000000000 {
                    return -1
                }
            }
        }
        return totalPassingCars
    }
    
    //Cyclic Rotation (Rotate an array K times)
    //Given an array A and integer K, rotate A to the right K times.
    func rotateArray(_ array: [Int], _ k: Int) -> [Int] {
        guard !array.isEmpty else { return array }
        let n = array.count
        let shift = k % n
        return Array(array.suffix(shift) + array.prefix(n - shift))
    }
    
    //https://www.geeksforgeeks.org/check-if-an-array-is-a-permutation-of-numbers-from-1-to-n/
    //Check if an Array is a permutation of numbers from 1 to N
    func isArrayPermutationOf(nums: [Int]) -> Bool {
        let n = nums.count
        let sum = n * (n + 1) / 2
        let set = Set(nums)
        var result = 0
        for value in set {
            result += value
        }
        return result == sum
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var a_pointer = 0
        var b_pointer = 0
        var set = Set<Character>()
            while b_pointer < s.count {
                
            }
        return 0 //TODO
    }
    
    func maximumSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        let count = nums.count
        if count < k {
            return 0
        }
        var max = 0
        var map = [Int: Int]()
        var i = 0
        var j = 0
        var sum = 0
        while j < k {
            if let value = map[nums[j]] {
                i = i + 1
                j = j + 1
                sum = sum + nums[j] - nums[i]
            } else {
                sum = sum + nums[j]
                j = j + 1
                map[nums[j]] = 1
            }
        }
        max = sum
        while j < count {
            sum = sum + nums[j] - nums[i]
            if sum > max {
                max = sum
            }
            i = i + 1
            j = j + 1
        }
        return max
    }
    
    //https://leetcode.com/problems/subarray-sum-equals-k/
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var dict = [Int: Int]()
        dict[0] = 1
        var preSum = 0
        var count = 0
        for i in 0..<nums.count {
            preSum = preSum + nums[i]
            var remove = preSum - k
            if let value = dict[remove] {
                count = count + value
            }
            if let value = dict[preSum] {
                dict[preSum] = value + 1
            }
        }
        return count
    }
    
    //Find Subarray with given sum | Set 1 (Non-negative Numbers)
    //https://www.geeksforgeeks.org/find-subarray-with-given-sum/
    // {1, 4, 20, 3, 10, 5}, sum = 33
    //https://leetcode.com/problems/subarray-sum-equals-k/ [not running in case of negative number]
    
    
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
    
    // TWO SUM https://leetcode.com/problems/two-sum/description/
    //Given an array of integers nums and an integer target, return
    //indices of the two numbers such that they add up to target.
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        for i in 0..<nums.count {
            let value = nums[i]
            var complement = target - value
            if let index = map[complement] {
                return [i, index]
            } else {
                map[value] = i
            }
        }
        return [0, 0]
    }
        
}


