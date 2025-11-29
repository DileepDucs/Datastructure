//
//  ViewController.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 28/06/24.
//

import UIKit

class Device {
    var id: String
    init(id: String) {
        self.id = id   // `self` clarifies we mean instance property
    }
    
    func showID() {
        print("Device ID: \(self.id)") // instance member
    }
    
    static var category = "Electronics"
    
    static func printCategory() {
        print("Category: \(Self.category)") // type member
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let tree = Tree()
        //tree.isBinaryTreeBalancedOptimised(<#T##root: Tree.Node?##Tree.Node?#>)
        //let array = ArrayDS()
        //array.minEatingSpeed([3,6,7,11], 8)
        //tries()
        //dynamicProblem()
        //frequentlyAsked()
        
//        let d = Device(id: "123")
//        d.showID()             // Device ID: 123
//        Device.printCategory() // Category: Electronics
        graph()

    }
    
    func graph() {
        let graph = Graph()
        //dijkstra(graph: graph)
        findCheapestPrice(graph: graph)
    }
    // helper func
    
    func dijkstra(graph: Graph) {
        let n = 5 //Number of vertices = 5
        let edges = [
            [0, 1, 2],
            [0, 2, 4],
            [1, 2, 1],
            [1, 3, 7],
            [2, 4, 3],
            [3, 4, 1]
        ]
        let src = 0
        graph.dijkstra(n, edges, src)
    }
    func findCheapestPrice(graph: Graph) {
        let n = 4
        let flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]]
        let src = 0
        let dst = 3
        let k = 1
        let result = graph.findCheapestPrice(4, flights, src, dst, k)
        print(result)
    }
    
    
    func frequentlyAsked() {
        let freAsked = FrequentlyAsked()
        let coins = [1, 2, 5], amount = 11
        freAsked.coinChange(coins, amount)
    }
    
    func dynamicProblem() {
        let weights = [1, 2, 3, 4]
        let values = [1, 4, 5, 7]
        let capacity = 5
        let dynamic = DynamicProgramming()
        let result = dynamic.knapsack(weights: weights, values: values, capacity: capacity)
        print(result)
    }
    
    
    func tries() {
        var trie = Trie()
        trie.insert("abc")
        print(trie)
        trie.search("apple")   // return True
        trie.search("app")     // return False
        trie.startsWith("app") // return True
        trie.insert("app")
        trie.search("app")     // return True
    }
}

