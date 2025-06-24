//
//  Trie.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 22/06/25.
//

import Foundation

// Trie Data Structure

//https://leetcode.com/problems/implement-trie-prefix-tree/description/
//https://www.youtube.com/watch?v=AXjmTQ8LEoI

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEnd: Bool = false
}

class Trie {
    private let root = TrieNode()

    init() {}

    // Insert a word into the Trie
    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isEnd = true
    }

    // Search for a full word in the Trie
    func search(_ word: String) -> Bool {
        guard let node = findNode(word) else {
            return false
        }
        return node.isEnd
    }

    // Check if any word starts with the given prefix
    func startsWith(_ prefix: String) -> Bool {
        return findNode(prefix) != nil
    }

    // Helper: Traverse the Trie based on input string
    private func findNode(_ str: String) -> TrieNode? {
        var node = root
        for char in str {
            guard let nextNode = node.children[char] else {
                return nil
            }
            node = nextNode
        }
        return node
    }
}
