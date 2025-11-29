//
//  Graph.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 20/02/25.
//

import Foundation

/*
    
 Graph is collection of nodes(vertices) and connections(edges) between them.
 Graph are used to represent relationship between objects.(ex- social network, map, dependency graph)
 
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
     
     *///🟢
    func bfs(graph: Graph, start: Int) {
        var visited = Set<Int>()
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
     
     *///🟢
    func dfs(graph: Graph, start: Int) {
        var visited = Set<Int>()
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
    ///🟢
    func bfsAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Set<Int>()
        var queue = Queue<Int>()
        
        // Step 1: Start at node `start`
        visited.insert(start)
        queue.enqueue(start)
        
        while !queue.isEmpty {
            guard let current = queue.dequeue() else { return }
            print("Visited node:", current)
            
            // Step 2: Check all connections for current node
            for neighbor in 0..<n {
                if matrix[current][neighbor] == 1 && !visited.contains(neighbor) {
                    visited.insert(neighbor)
                    queue.enqueue(neighbor)
                }
            }
        }
    }
    
    //Depth-First Search (DFS) using a stack (iterative version) on a connected graph represented by an adjacency matrix, implemented in Swift.
    
    ///🟢
    func dfsIterativeAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Set<Int>()
        var stack = Stack<Int>()
        stack.push(start)
        
        while !stack.isEmpty {
            guard let current = stack.pop() else { return }
            
            if !visited.contains(current) {
                visited.insert(current)
                print("Visited node:", current)
                
                // Push neighbors in reverse to maintain left-to-right traversal
                for neighbor in stride(from: n - 1, through: 0, by: -1) {
                    if matrix[current][neighbor] == 1 && !visited.contains(neighbor) {
                        stack.push(neighbor)
                    }
                }
            }
        }
    }
    
    
    // Recursion // Not important
    func bfsRecursiveAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Set<Int>()
        var queue = Queue<Int>()
        queue.enqueue(start)
        visited.insert(start)

        func bfsHelper(_ queue: inout Queue<Int>) {
            guard let current = queue.dequeue() else { return }
            print("Visited node:", current)

            for neighbor in 0..<n {
                if matrix[current][neighbor] == 1 && !visited.contains(neighbor) {
                    visited.insert(neighbor)
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
    // Not important
    func dfsRecursiveAdjacencyMatrix(_ matrix: [[Int]], start: Int) {
        let n = matrix.count
        var visited = Set<Int>()
        
        func dfs(_ node: Int) {
            visited.insert(node)
            print("Visited:", node)
            
            for neighbor in 0..<n {
                if matrix[node][neighbor] == 1 && !visited.contains(neighbor) {
                    dfs(neighbor)
                }
            }
        }
        dfs(start)
    }
    
    /*2. Detecting a Path Between Two Nodes(source and destination)
        * Given an undirected graph, check if there is a path between two nodes.
     https://leetcode.com/problems/find-if-path-exists-in-graph/
     There is a bi-directional graph with n vertices, where each vertex is labeled from 0 to n - 1 (inclusive). The edges in the graph are represented as a 2D integer array edges, where each edges[i] = [ui, vi] denotes a bi-directional edge between vertex ui and vertex vi. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself.

     You want to determine if there is a valid path that exists from vertex source to vertex destination.
     Given edges and the integers n, source, and destination, return true if there is a valid path from source to destination, or false otherwise.

     Example 1:

     Input: n = 3, edges = [[0,1],[1,2],[2,0]], source = 0, destination = 2
     Output: true
     Explanation: There are two paths from vertex 0 to vertex 2:
     - 0 → 1 → 2
     - 0 → 2
     */
    ///🟢
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
            let graph = Graph()
            for edge in edges {
                let u = edge[0]
                let v = edge[1]
                graph.addEdge(u, v, bidirectional: true)
            }
            return bfsTraversal(graph: graph, source: source, destination: destination)
        }

        func bfsTraversal(graph: Graph, source: Int, destination: Int) -> Bool {
            var queue = Queue<Int>()
            var visited: Set<Int> = []
            queue.enqueue(source)
            visited.insert(source)
            
            while !queue.isEmpty {
                guard let current = queue.dequeue() else { return false }
                if current == destination {
                    return true
                }
                if let neighbors = graph.adjacencyList[current] {
                    for neighbor in neighbors {
                        if !visited.contains(neighbor) {
                            visited.insert(neighbor)
                            queue.enqueue(neighbor)
                        }
                    }
                }
            }
            return false
        }
    }
    
    
    
    /*To check if an undirected graph is connected or not using DFS or BFS
     ✅ What it means for a graph to be "connected":
     All nodes are reachable from any starting node.
     In BFS, if we visit all nodes starting from any node (e.g., node 0), and the visited count equals the total number of nodes n, the graph is connected.
     https://www.geeksforgeeks.org/java-program-to-check-whether-undirected-graph-is-connected-using-dfs/
     
     let n = 5
     let edges = [[0, 1], [1, 2], [2, 3], [3, 4]]
     */
    
    // there should be helper function to generate adjecency List for given edges()
    func isConnectedUsingBFS(graph: Graph, start: Int, n: Int) -> Bool{
        var visited = Set<Int>()
        var queue = Queue<Int>()
        
        queue.enqueue(start)
        visited.insert(start)
        
        while !queue.isEmpty {
            guard let current = queue.dequeue() else { return false } // Dequeue
            if let neighbors = graph.adjacencyList[current] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor) {
                        queue.enqueue(neighbor) // Enqueue unvisited neighbors
                        visited.insert(neighbor)
                    }
                }
            }
        }
        return n == visited.count
    }
    
    /*
     3. Number of Connected Components
         * Count how many disconnected parts (components) are in a graph.
     https://leetcode.com/problems/count-the-number-of-complete-components/
     
     https://www.youtube.com/watch?v=6-dJ6nJ6t4c
     */
    ////🔴
    func countCompleteComponents(_ n: Int, _ edges: [[Int]]) -> Int {
        var graph = Array(repeating: [Int](), count: n)
        var visited = Array(repeating: false, count: n)
        var result = 0
        for edge in  edges {
            let u = edge[0]
            let v = edge[1]
            graph[u].append(v)
            graph[v].append(u)
        }
        
        for i in 0..<n {
            if visited[i] {
                continue
            }
            var queue = Queue<Int>()
            queue.enqueue(i)
            visited[i] = true
            var nodeCount = 0
            var edgeCount = 0
            
            while !queue.isEmpty {
                guard let current = queue.dequeue() else { break }
                nodeCount += 1
                edgeCount += graph[current].count
                
                for neighobur in graph[current] {
                    if !visited[neighobur] {
                        queue.enqueue(neighobur)
                        visited[neighobur] = true
                    }
                }
            }
            
            if edgeCount == nodeCount * (nodeCount - 1) {
                result += 1
            }
        }
        return result
    }

    // Same above problems
    func countCompleteComponentsBFS(_ n: Int, _ edges: [[Int]]) -> Int {
        let graph = Graph()
        for value in edges {
            let u = value[0]
            let v = value[1]
            graph.addEdge(u, v, bidirectional: true)
        }
        var result = 0
        var queue = Queue<Int>()
        var visitaed = Set<Int>()
    
        for start in 0..<n {
            if visitaed.contains(start) {
                continue
            }
            queue.enqueue(start)
            visitaed.insert(start)
        
            var nodeCount = 0
            var edgeCount = 0
            while !queue.isEmpty {
                guard let current = queue.dequeue() else { break }
            
                // main logic is here
                nodeCount += 1
                edgeCount += graph.adjacencyList[current]?.count ?? 0
            
                if let nighbours = graph.adjacencyList[current] {
                    for nighbour in nighbours {
                        if !visitaed.contains(nighbour) {
                            visitaed.insert(current)
                            queue.enqueue(current)
                        }
                    }
                }
            }
            if edgeCount == (nodeCount * (nodeCount - 1)) {
                result += 1
            }
        }
        return result
    }
    
    /*Time Complexity
     Time    O(N + E)
     Space    O(N + E) (graph + visited + queue)
     */
    
    
    /**
     4. Matrix as a Graph
         * Number of islands (Leetcode 200)
     Problem Summary:
     You’re given a 2D grid of '1's (land) and '0's (water).
     An island is formed by connecting adjacent lands horizontally or vertically.
     Your task is to count the number of islands.
     https://www.youtube.com/watch?v=ZgCZfXPo3hI
     https://leetcode.com/problems/number-of-islands/description/
     */
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.isEmpty || grid[0].isEmpty {
            return 0
        }
        var mutableGrid = grid
        var resultCount = 0
        for i in 0..<mutableGrid.count {
            for j in 0..<mutableGrid[i].count {
                if mutableGrid[i][j] == "1" {
                    numIslandsDFS(&mutableGrid, i: i, j: j)
                    resultCount += 1
                }
            }
        }
        return resultCount
    }
    
    func numIslandsDFS(_ grid: inout [[Character]], i: Int, j: Int) {
        if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count || grid[i][j] == "0" {
            return
        }
        grid[i][j] = "0"
        numIslandsDFS(&grid, i: i + 1, j: j)
        numIslandsDFS(&grid, i: i - 1, j: j)
        numIslandsDFS(&grid, i: i, j: j + 1)
        numIslandsDFS(&grid, i: i, j: j - 1)
    }
    
    /*Time Complexity
     Time   O(nxm)
     Space  O(nxm)
     */
    
    
    /**
        733 - Flood Fill
        https://leetcode.com/problems/flood-fill/description/
     */
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        var mutableImage = image
        let startColor = mutableImage[sr][sc]
        
        if startColor == color { return image }
        
        func dfs(r: Int, c: Int) {
            if r < 0 || c < 0 || r >= mutableImage.count || c >= mutableImage[0].count || mutableImage[r][c] != startColor {
                return
            }
            
            mutableImage[r][c] = color
            dfs(r: r, c: c + 1)
            dfs(r: r, c: c - 1)
            dfs(r: r + 1, c: c)
            dfs(r: r - 1, c: c)
        }
        
        dfs(r: sr, c: sc)
        return mutableImage
    }
    
    /*Time: O(N × M) — each cell is visited once.
     Space: O(N × M) worst case due to recursion stack or queue.
     */
    

    func orangesRotting(_ grid: [[Int]]) -> Int {
        var mutableGrid = grid
        var resultCount = 0
        var freshApple = 0
        var time = 0
        var queue = Queue<(Int, Int)>()
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == 2 {
                    queue.enqueue((i, j))
                } else if grid[i][j] == 1 {
                    freshApple += 1
                }
            }
        }
        
        if freshApple == 0 { return 0 }
        
        var directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        
        while !queue.isEmpty {
            guard let (r, c) = queue.dequeue() else { break }
        
            var isUpdate = false
            
            for (dr, dc) in directions {
                let nRow = r + dr
                let nCol = c + dc
                if nRow >= 0 && nCol >= 0 && nRow < grid.count && nCol < grid[0].count && mutableGrid[nRow][nCol] == 1 {
                    mutableGrid[nRow][nCol] = 2
                    isUpdate = true
                    queue.enqueue((nRow, nCol))
                    resultCount += 1
                }
            }
            if isUpdate {
                time += 1
            }
        }
        return freshApple == resultCount ? time : -1
    }

    /*
        Check if graph is bipartite (using BFS color assignment)
     https://leetcode.com/problems/is-graph-bipartite/
     
    */
    
    /*
     5. Cycle Detection
         * Detect a cycle in an undirected graph.
     https://leetcode.com/problems/detect-cycles-in-2d-grid/description/
     https://www.geeksforgeeks.org/detect-cycle-undirected-graph/
     */


    /*
     Word Search II -
     https://leetcode.com/problems/word-search-ii/description/
     

     Given an m x n board of characters and a list of strings words, return all words on the board.

     Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.
     
     */

    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let trie = Trie()
        for word in words {
            trie.insert(word)
        }
        var board = board
        var results = Set<String>()
        let rows = board.count
        let columns = board[0].count
        for i in 0..<rows {
            for j in 0..<columns {
                wordSearchIIdfs(board: &board, row: i, col: j, result: &results, node: trie.root)
            }
        }
        return Array(results)
    }

    func wordSearchIIdfs(board: inout [[Character]], row: Int, col: Int, result: inout Set<String>, node: TrieNode) {
        if row < 0 || row >= board.count || col < 0 || col >= board[0].count {
            return
        }
        let char = board[row][col]
        if char == "#" || node.children[char] == nil {
            return
        }
        guard let nextNode = node.children[char] else { return }
        if let word = nextNode.word {
            result.insert(word)
        }
        board[row][col] = "#"
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        for (dx, dy) in directions {
            wordSearchIIdfs(board: &board, row: row + dx, col: col + dy, result: &result, node: nextNode)
        }
        
        // Restore original character
        board[row][col] = char
    }
    
    // Helper func to read All the words from given Grid.
    func readAllWords(words: [String]) {
        for word in words {
            for char in word {

            }
        }
    }

    //Minimum cast spanning tree(MST)
    //Prims - (Algo)
    //https://leetcode.com/problems/min-cost-to-connect-all-points/
    //https://www.notion.so/Minimum-cast-spanning-tree-MST-282b852453f4805cacd5d64220f1a166?source=copy_link
    // Inside FrequentlyAsked (file) interview questions
    
    
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
