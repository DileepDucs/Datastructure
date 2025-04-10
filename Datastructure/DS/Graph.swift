//
//  Graph.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 20/02/25.
//

import Foundation

/*
 Graph traversal is a fundamental concept where we visit all nodes in a graph systematically.
 The two most common traversal techniques are:

 Breadth-First Search (BFS) - using  Queue
 Depth-First Search (DFS)- using Stack
 
 */
class Graph {
    
    //We will use an adjacency list representation because it is more space-efficient.
    var adjacencyList: [Int: [Int]] = [:] // Dictionary of lists
    
    func addEdge(_ u: Int, _ v: Int, bidirectional: Bool = true) {
        
        if adjacencyList[u] == nil {
            adjacencyList[u] = []
        }
        if adjacencyList[v] == nil {
            adjacencyList[v] = []
        }
        
        adjacencyList[u]?.append(v)
        
        if bidirectional {
            adjacencyList[v]?.append(u)
        }
    }
    
    func printGraph() {
        for (node, neighbors) in adjacencyList {
            print("\(node) -> \(neighbors)")
        }
    }
}

class GraphDataStructure {
    /*
     1. Iterative Breadth-First Search (BFS)
     
     Concept
     BFS explores all nodes level by level before moving to the next depth.
     It uses a queue (FIFO) to track nodes to visit next.
     
     Steps
     1.Start from a node and enqueue it.
     2.While the queue is not empty:
        -Dequeue a node, process it, and mark it as visited.
        -Enqueue all unvisited neighbors.
     
     */
    func bfs(graph: Graph, start: Int) {
        var visited: Set<Int> = []
        var queue = Queue<Int>()
        queue.enqueue(start)
        visited.insert(start)
        while !queue.isEmpty {
            let node = queue.dequeue() // Dequeue
            
            print(node!, terminator: " ") // Process node
            
            if let neighbors = graph.adjacencyList[node!] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        queue.enqueue(neighbor) // Enqueue unvisited neighbors
                        visited.insert(neighbor)
                    }
                }
            }
        }
    }
    
    /*
     Time & Space Complexity for bfs traversal
     * Time Complexity: O(V+E)
         * Each node is visited once, and all edges are checked once.
     
     * Space Complexity: O(V)
         * The queue stores up to O(V) nodes in the worst case.

     */
    
    
    
    /*
     2. Iterative Depth-First Search (DFS)

     Concept

     DFS explores as far as possible along each branch before backtracking.
     It uses a stack (LIFO) to track nodes to visit next.
     
     Steps
     1.Start from a node and push it onto a stack.
     2.While the stack is not empty:
        -Pop a node, process it, and mark it as visited.
        -Push all unvisited neighbors onto the stack.
     
     */
    func dfs(graph: Graph, start: Int) {
        var visited: Set<Int> = []
        var stack = Stack<Int>()
        stack.push(start)
        visited.insert(start)
        
        while !stack.isEmpty {
            let node = stack.pop() // Pop from stack
            
            //if visited.contains(node!) { continue }
            
            print(node!, terminator: " ") // Process node
            visited.insert(node!)
            
            if let neighbors = graph.adjacencyList[node!] {
                for neighbor in neighbors.reversed() {
                    if !visited.contains(neighbor) {
                        stack.push(neighbor) // Push unvisited neighbors
                    }
                }
            }
        }
    }
    
    //Example Usage
    
    func testingGraph() {
        let graph = Graph()
        graph.addEdge(0, 1)
        graph.addEdge(0, 2)
        graph.addEdge(1, 3)
        graph.addEdge(1, 4)
        graph.addEdge(2, 5)
        graph.addEdge(2, 6)
        
        print("adjacency list representation:")
        graph.printGraph()

        print("BFS Traversal:")
        bfs(graph: graph, start: 0)
        
        print("DFS Traversal:")
        dfs(graph: graph, start: 0)
        
        /*
         BFS Traversal:
         0 1 2 3 4 5 6 */
    }
    
    //https://app.codility.com/demo/results/trainingGXYJTW-5XM/
    public func solution(_ A : [Int], _ B : [Int]) -> Int {
        // Implement your solution here
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
                dict[width]?.append(value)
                dict[height]?.append(value)
            }
        }
        
        for (_, values) in dict {
            let count = values.count
            maxResult = max(maxResult, count)
            
        }
        return maxResult
    }

}
