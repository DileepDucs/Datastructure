//
//  Trie.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 22/06/25.
//

import Foundation

// Trie Data Structure

//https://www.notion.so/Implement-Trie-Prefix-Tree-280b852453f480868ba2daaab7e3de96?source=copy_link
//https://leetcode.com/problems/implement-trie-prefix-tree/description/
//https://www.youtube.com/watch?v=AXjmTQ8LEoI

/*
 208- Implement Trie (Prefix Tree)
 
 A Trie, or prefix tree, is a tree-based data structure that’s useful for storing strings in a way that makes prefix lookups efficient. It’s often used in autocomplete, dictionary, and spell-checker problems.
 The key idea is that each node represents a character, and a path from the root to a node represents a prefix of one or more words.”
 
 --
 Implement the Trie class:

 Trie() Initializes the trie object.
 void insert(String word) Inserts the string word into the trie.
 boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
 boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.
 */

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEnd: Bool = false
    var word: String?   //Optional: stores the complete word at terminal nodes, useful for certain problems
}

class Trie {
    let root = TrieNode()

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
