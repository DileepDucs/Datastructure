//
//  LRUCache.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 25/05/25.
//

/*
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

 Implement the LRUCache class:

 LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 int get(int key) Return the value of the key if the key exists, otherwise return -1.
 void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 The functions get and put must each run in O(1) average time complexity.

  

 Example 1:

 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]
 https://leetcode.com/problems/lru-cache/description/
 
 Approach:
 🧠 Design Idea

 To achieve O(1) time for both get and put, we combine two data structures:

 1. Dictionary
 Maps key -> node (for fast lookup).
 2. Doubly Linked List
 Maintains the usage order (most recently used near the head, least recently used near the tail).
 Allows O(1) insert and delete operations.
 
 https://www.youtube.com/watch?v=z9bJUPxzFOw&t=1213s
 */
    
class LRUCache {
    
    class Node {
        var key: Int
        var value: Int
        var prev: Node?
        var next: Node?
        
        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    private var capacity: Int
    private var cache: [Int: Node] = [:]
    private var head: Node
    private var tail: Node
    
    init(_ capacity: Int) {
        self.capacity = capacity
        self.head = Node(0, 0) // Dummy head
        self.tail = Node(0, 0) // Dummy tail
        head.next = tail
        tail.prev = head
    }
    
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            moveToHead(node) // Move accessed node to head
            return node.value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = Node(key, value)
            cache[key] = newNode
            addToHead(newNode)
            
            if cache.count > capacity {
                if let tailNode = removeTail() {
                    cache.removeValue(forKey: tailNode.key)
                }
            }
        }
    }
    
    private func addToHead(_ node: Node) {
        node.next = head.next
        node.prev = head
        head.next?.prev = node
        head.next = node
    }
    
    private func removeNode(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
    
    private func moveToHead(_ node: Node) {
        removeNode(node)
        addToHead(node)
    }
    
    private func removeTail() -> Node? {
        if let tailNode = tail.prev, tailNode !== head {
            removeNode(tailNode)
            return tailNode
        }
        return nil
    }
}
