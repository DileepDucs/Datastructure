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
            guard let current = queue.dequeue() else { break } // Dequeue
            
            print(current, terminator: " ") // Process node
            
            if let neighbors = graph.adjacencyList[current] {
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
     2. Iterative Depth-First Search (DFS) - Stack
     //https://www.youtube.com/watch?v=iaBEKo5sM7w
     //https://www.geeksforgeeks.org/depth-first-search-or-dfs-for-a-graph/
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
        
        while !stack.isEmpty {
            guard let current = stack.pop() else { break } // Pop from stack
            
            if !visited.contains(current) {
                visited.insert(current)
                print(current, terminator: " ")
                
                // Add neighbors in reverse order to process left to right
                if let neighbors = graph.adjacencyList[current] {
                    for neighbor in neighbors.reversed() {
                        if !visited.contains(neighbor) {
                            stack.push(neighbor) // Push unvisited neighbors
                        }
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
    
    
    /*Breadth-First Search (BFS) traversal using an adjacency matrix for a connected graph in Swift
     
     What is an Adjacency Matrix?

     An adjacency matrix is a 2D array where:

     Each row/column represents a node.
     A cell matrix[i][j] == 1 means there’s an edge between node i and node j.
     A 0 means no edge.
     let matrix = [
         [0, 1, 1, 0],  // Node 0 connects to 1 and 2
         [1, 0, 1, 1],  // Node 1 connects to 0, 2, and 3
         [1, 1, 0, 1],  // Node 2 connects to 0, 1, and 3
         [0, 1, 1, 0]   // Node 3 connects to 1 and 2
     ]
     
       0
      / \
     1---2
      \ /
       3
     
     Data Structure    Adjacency matrix (2D array)
     BFS Tooling       Queue + Visited Array
     Time Complexity   O(V²) for adjacency matrix
     Use Case          Works well for dense graphs
     
     */
    
    //https://medium.com/@dileep.ducs/graph-adjacency-matrix-in-swift-fcb811c03730
    
    func bfsAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Array(repeating: false, count: n)
        var queue = Queue<Int>()
        
        // Step 1: Start at node `start`
        visited[start] = true
        queue.enqueue(start)
        
        while !queue.isEmpty {
            guard let current = queue.dequeue() else { return }
            print("Visited node:", current)
            
            // Step 2: Check all connections for current node
            for neighbor in 0..<n {
                if matrix[current][neighbor] == 1 && !visited[neighbor] {
                    visited[neighbor] = true
                    queue.enqueue(neighbor)
                }
            }
        }
    }
    
    //Depth-First Search (DFS) using a stack (iterative version) on a connected graph represented by an adjacency matrix, implemented in Swift.
    
    func dfsIterativeAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Array(repeating: false, count: n)
        var stack = Stack<Int>()
        stack.push(start)
        
        while !stack.isEmpty {
            guard let current = stack.pop() else { return }
            
            if !visited[current] {
                visited[current] = true
                print("Visited node:", current)
                
                // Push neighbors in reverse to maintain left-to-right traversal
                for neighbor in stride(from: n - 1, through: 0, by: -1) {
                    if matrix[current][neighbor] == 1 && !visited[neighbor] {
                        stack.push(neighbor)
                    }
                }
            }
        }
    }
    
    
    // Recursion
    func bfsRecursiveAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Array(repeating: false, count: n)
        var queue = Queue<Int>()
        queue.enqueue(start)
        visited[start] = true

        func bfsHelper(_ queue: inout Queue<Int>) {
            guard let current = queue.dequeue() else { return }
            print("Visited node:", current)

            for neighbor in 0..<n {
                if matrix[current][neighbor] == 1 && !visited[neighbor] {
                    visited[neighbor] = true
                    queue.enqueue(neighbor)
                }
            }

            bfsHelper(&queue)  // recursive call with updated queue
        }

        bfsHelper(&queue)
    }
    /*
     Time Complexity: O(n²)
     
     Space Complexity

    1. Visited array: O(n)
    Keeps track of whether each node has been visited.
    2. Queue: O(n)
    In the worst case, all nodes are added to the queue once.
    3. Recursion call stack: O(n)
    One recursive call per node in the worst case.
    ✅ Space Complexity: O(n)
     */
    
    
    //When using recursion, the call stack provided by the system acts as the stack automatically.
    //No other custom stack is required
    
    func dfsRecursive(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Array(repeating: false, count: n)
        
        func dfs(_ node: Int) {
            visited[node] = true
            print("Visited:", node)
            
            for neighbor in 0..<n {
                if matrix[node][neighbor] == 1 && !visited[neighbor] {
                    dfs(neighbor)
                }
            }
        }
        dfs(start)
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
