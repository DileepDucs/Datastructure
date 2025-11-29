//
//  Graph+Dijkstra.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 15/10/25.
//

extension Graph {
    
    //Dijkstra’s Algorithm
    //https://www.notion.so/Dijkstra-s-Algorithm-28db852453f480a787dfd677ce156fd5?source=copy_link
    func dijkstra(_ n: Int, _ edges: [[Int]], _ src: Int) -> [Int] {
        // Build adjacency list with weight
        var adjecencyList = [Int: [(Int, Int)]]()
        for edge in edges {
            let u = edge[0], v = edge[1], weight = edge[2]
            if adjecencyList[u] == nil {
                adjecencyList[u] = [(Int, Int)]()
            }
            adjecencyList[u]?.append((v, weight))
            
            /*or the more concise idiomatic Swift version:
             
            adjecencyList[u, default: []].append((v, weight)) */
        }
        
        // Initialize distances
        var dist = Array(repeating: Int.max, count: n)
        dist[src] = 0
        
        // Min Heap: (node, cost)
        var heap = [(Int, Int)]()
        heap.append((src, 0))
        
        while !heap.isEmpty {
            heap.sort { $0.1 < $1.1 }
            let (node, cost) = heap.removeFirst()
            
            if cost > dist[node] { continue }
            
            for (neighbor, weight) in adjecencyList[node] ?? [] {
                let newCost = cost + weight
                if newCost < dist[neighbor] {
                    dist[neighbor] = newCost
                    heap.append((neighbor, newCost))
                }
            }
        }
        
        return dist
    }

    
    
    //https://leetcode.com/problems/cheapest-flights-within-k-stops/
    
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        // Step 1: Initialize distances
        var dist = Array(repeating: Int.max, count: n)
        dist[src] = 0
        
        // Step 2: Relax edges up to K + 1 times (K stops → K+1 flights)
        for _ in 0...k {
            // Copy of previous iteration to avoid early updates
            var tempDist = dist
            
            // Relax all edges
            for flight in flights {
                let u = flight[0], v = flight[1], w = flight[2]
                
                // If source node is reachable
                if dist[u] != Int.max && dist[u] + w < tempDist[v] {
                    tempDist[v] = dist[u] + w
                }
            }
            
            dist = tempDist
        }
        // Step 3: Result
        return dist[dst] == Int.max ? -1 : dist[dst]
        
    }
    
}
