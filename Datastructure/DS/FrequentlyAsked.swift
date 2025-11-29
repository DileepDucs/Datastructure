//
//  FrequentlyAsked.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 03/08/25.
//

// These are the frequently asked interview questions.
class FrequentlyAsked {
    
    //Minimum cast spanning tree(MST)
    //Prims - (Algo)
    //https://leetcode.com/problems/min-cost-to-connect-all-points/
    //https://www.notion.so/Minimum-cast-spanning-tree-MST-282b852453f4805cacd5d64220f1a166?source=copy_link
    func minCostConnectPoints(_ points: [[Int]]) -> Int {
        var n = points.count
        var adjList = [Int: [(Int, Int)]]()
        for i in 0..<n {
            adjList[i] = []
        }
        for i in 0..<n {
            for j in i + 1..<n {
                let distance = manhantDistance(x1: points[i][0], x2: points[j][0], y1: points[i][1], y2: points[j][1])
                adjList[i]?.append((distance, j))
                adjList[j]?.append((distance, i))
            }
        }
        var result = 0
        var minHeap = [(Int, Int)]()
        minHeap.append((0,0))
        var visited = Set<Int>()
        
        while visited.count < n {
            minHeap.sort { $0.0 < $1.0 }
            let (cost, node) = minHeap.removeFirst()
            if visited.contains(node) { continue }
            visited.insert(node)
            result += cost
            
            if let nighbours = adjList[node] {
                for value in nighbours {
                    if !visited.contains(value.1) {
                        minHeap.append(value)
                    }
                }
            }
        }
        return result
        
    }
    
    private func manhantDistance(x1: Int, x2: Int, y1: Int, y2: Int) -> Int {
        return (abs(x1 - x2) + abs(y1 - y2))
    }
    
    //https://www.notion.so/Dynamic-Programming-DP-in-Swift-252b852453f4802f97b3ca7f431aa7f7
    // 134 Gas Station
    //https://leetcode.com/problems/gas-station/description/
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var currentGain = 0
        var count = gas.count
        var totalGas = 0
        var start = 0
        for i in 0..<count {
            var gain = gas[i] - cost[i]
            totalGas += gain
            currentGain += gain
            if currentGain < 0 {
                start = i + 1
                currentGain = 0
            }
        }
        return totalGas >= 0 ? start : -1
    }
    
    //### Recursive (Naive) – ❌ Exponential Time
    //https://www.notion.so/Dynamic-Programming-DP-in-Swift-252b852453f4802f97b3ca7f431aa7f7?source=copy_link
    func fib(_ n: Int) -> Int {
        if n <= 1 { return n }
        return fib(n-1) + fib(n-2)
    }
    /*⏱ Time Complexity: `O(2^n)`
    💾 Space Complexity: `O(n)` (due to recursion stack)*/
    
    //### Top-Down (Memoization) – ✅ Optimized
    func fibMemo(_ n: Int, _ memo: inout [Int: Int]) -> Int {
        if n <= 1 { return n }
        if let val = memo[n] { return val } // return cached result

        let result = fibMemo(n-1, &memo) + fibMemo(n-2, &memo)
        memo[n] = result
        return result
    }
    /*⏱ Time Complexity: `O(n)`
    💾 Space Complexity: `O(n)`*/

    //### Bottom-Up (Tabulation) – ✅ Efficient Iterative
    func fibTab(_ n: Int) -> Int {
        if n <= 1 { return n }
        var dp = [0, 1]

        for i in 2...n {
            dp.append(dp[i-1] + dp[i-2])
        }
        return dp[n]
    }
    /*⏱ Time Complexity: `O(n)`
    💾 Space Complexity: `O(n)` (can be reduced to `O(1)` using two variables)*/
    
    
    // 322 Coin Change
    //https://leetcode.com/problems/coin-change/
    //https://www.youtube.com/watch?v=NNcN5X1wsaw
    /*1. Dynamic Programming (Bottom-Up) Memoization
     We build a DP array where dp[x] = min coins to make amount x.
     Initialize dp of size amount + 1 with amount + 1 (infinity).
     dp[0] = 0 (0 coins to make amount 0).
     For each coin, update dp:
     dp[x] = min(dp[x], dp[x - coin] + 1)*/
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        for x in 1...amount {
            for coin in coins {
                if coin <= x {
                    dp[x] = min(dp[x], dp[x - coin] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
    /**
     Time Complexity: O(amount * n) where n = coins.count
     Space Complexity: O(amount)
     */
    
    
}
