//
//  Tree.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 09/02/25.
//

import Foundation

class Tree {
    
    class Node {
        var data: Int
        var left: Node?
        var right: Node?
        init(_ data: Int) {
            self.data = data
        }
    }
    
    //MARK: Recurcive
    //Recursive Inorder Traversal (DFS)
    func inorderTraversal(root: Node?) {
        guard let root = root else { return }
        inorderTraversal(root: root.left)
        print("\(root.data)")
        inorderTraversal(root: root.right)
    }
    
    func preorderTraversal(root: Node?) {
        guard let root = root else { return }
        print("\(root.data)")
        preorderTraversal(root: root.left)
        preorderTraversal(root: root.right)
    }
    
    func postOrderTraversal(root: Node?) {
        guard let root = root else { return }
        postOrderTraversal(root: root.left)
        postOrderTraversal(root: root.right)
        print("\(root.data)")
    }
    
    //MARK: Iterative
    
    //10. How do you print all nodes of a given binary tree using inorder traversal without recursion?
    //Inorder Tree Traversal using Stack in Swift
    //Iterative Inorder Traversal (Using Stack)
    func inorderTreeTraversalIterative(root: Node?) {
        var stack = Stack<Node>()
        var current = root
        while current != nil || stack.isEmpty == false {
            while current != nil {
                stack.push(current!)
                current = current?.left
            }
            current = stack.pop()
            guard let currentNode = current else { return }
            print(currentNode.data)
            current = currentNode.right
        }
    }
    
    //Morris Inorder Traversal (O(1) Space, No Stack)
    //Inorder Tree Traversal without recursion and without stack in Swift. ( Morris Traversal )
    func morisTraversal(root: Node?) {
        var current = root
        var pre: Node? = nil
        while current != nil {
            if current?.left == nil {
                print(current?.data ?? "")
                current = current?.right
            } else {
                pre = current?.left
                while (pre?.right != nil) && (pre?.right !== current) {
                    pre = pre?.right
                }
                if pre?.right == nil {
                    pre?.right = current
                    current = current?.left
                } else {
                    pre?.right = nil
                    print(current!.data)
                    current = current?.right
                }
            }
        }
    }
    
    
    //9. How do you traverse a given binary tree in preorder without recursion?
    func preorderTreeTraverselIterative(root: Node?) {
        guard let root = root else { return }
        var stack = Stack<Node>()
        stack.push(root)
        while !stack.isEmpty {
            let node = stack.pop()
            print(node?.data ?? "")
            if let right = node?.right {
                stack.push(right)
            }
            if let left = node?.left {
                stack.push(left)
            }
        }
        
    }
    
    func isMirrorTree(root1: Node?, root2: Node?) -> Bool {
        if root1 == nil && root2 == nil {
            return true
        }
        if root1 != nil && root2 != nil && root1?.data == root2?.data {
            return isMirrorTree(root1: root1?.left, root2: root2?.right) && isMirrorTree(root1: root1?.right, root2: root2?.left)
        }
        return false
    }
    
    //Height of a Binary Tree
    //The height of a binary tree is the number of edges on the longest path from the root to a leaf.
    
    func height(root: Node?) -> Int {
        guard let root = root else { return -1 } // Return -1 if considering edges, 0 if considering nodes
        return 1 + max(height(root: root.left), height(root: root.right))
    }
    
    
    
    /*2. Diameter of a Binary Tree
    The diameter (or width) of a binary tree is the length of the longest path between any two nodes in the tree. It may or may not pass through the root.*/
    
    func diameter(root: Node?) -> Int {
        guard let root = root else { return 0 }
        let lHeight = height(root: root.left)
        let rHeight = height(root: root.right)
        let leftDiameter = diameter(root: root.left)
        let rightDiameter = diameter(root: root.right)
        return max(lHeight + rHeight + 1, max(leftDiameter, rightDiameter))
    }
    
    // Validate Binary Search Tree (LeetCode 98)
    //https://leetcode.com/problems/same-tree/
    func isSameTree(_ p: Node?, _ q: Node?) -> Bool {
        // If both trees are nil, they are the same
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil || p!.data != q!.data {
            return false
        }
        return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
    }
    
    //Problem: Given a binary tree, determine if it is a valid Binary Search Tree (BST).
    
    
    
    
    // https://leetcode.com/problems/binary-tree-level-order-traversal/
    /**
     Input: root = [3,9,20,null,null,15,7]
     Output: [[3],[9,20],[15,7]]
     */
    func levelOrder(_ root: Node?) -> [[Int]] {
        guard let root = root else { return [] }
        
        var result = [[Int]]()
        var queue = Queue<Node>()
        
        queue.enqueue(root)
        while !queue.isEmpty {
            var levelValues = [Int]()
            let levelSize = queue.count
            
            for i in 0..<levelSize {
                let node = queue.dequeue()
                levelValues.append(node?.data ?? 0)
                if let left = node?.left {
                    queue.enqueue(left)
                }
                if let right = node?.right {
                    queue.enqueue(right)
                }
            }
            result.append(levelValues)
        }
        return result
    }
    
    // print all diagonals of binary tree (Iterative)
    
    func printDiagonals(_ root: Node?) {
        guard let root = root else { return }
        var queue = Queue<Node>()
        
    }
}
