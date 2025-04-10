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
    /**
        Binary Tree Traversal (DFS & BFS)
        Problem: Implement Preorder, Inorder, Postorder Traversal.
     */
    
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
    //Iterative Inorder Traversal (Using Stack) (DFS Traversal)
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
    //https://leetcode.com/problems/binary-tree-inorder-traversal/submissions/1537761821/
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
    
    private func height(_ root: Node?) -> Int {
        guard let root = root else { return 0 } // Return -1 if considering edges, 0 if considering nodes
        return 1 + max(height(root.left), height(root.right))
    }
    
    
    
    /*2. Diameter of a Binary Tree
    https://leetcode.com/problems/diameter-of-binary-tree/description/
    The diameter (or width) of a binary tree is the length of the longest path between any two nodes in the tree. It may or may not pass through the root.*/
    
    func diameter(root: Node?) -> Int {
        guard let root = root else { return 0 }
        let lHeight = height(root.left)
        let rHeight = height(root.right)
        let leftDiameter = diameter(root: root.left)
        let rightDiameter = diameter(root: root.right)
        return max(lHeight + rHeight, max(leftDiameter, rightDiameter))
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
    //https://leetcode.com/problems/validate-binary-search-tree/submissions/1602711390/
    //https://www.youtube.com/watch?v=s6ATEkipzow
    
    func isValidBST(_ root: Node?) -> Bool {
        return validate(root, min: nil, max: nil)
    }
    
    private func validate(_ node: Node?, min: Int?, max: Int?) -> Bool {
        guard let node = node else {
            return true
        }
        
        if let min = min, node.data <= min {
            return false
        }
        if let max = max, node.data >= max {
            return false
        }
        
        return validate(node.left, min: min, max: node.data) &&
        validate(node.right, min: node.data, max: max)
    }
    
    /**
     In this article, we will discuss a simple yet efficient approach to solve the above problem.
     The idea is to use Inorder traversal and keep track of the previously visited node’s value. Since the inorder traversal of a BST generates a sorted array as output, So, the previous element should always be less than or equals to the current element.
     While doing In-Order traversal, we can keep track of previously visited Node’s value and if the value of the currently visited node is less than the previous value, then the tree is not BST.
     */
    
    private var prev: Node?
    
    func isValidBST_Efficient(_ root: Node?) -> Bool {
        return inorder(root)
    }
    
    private func inorder(_ node: Node?) -> Bool {
        guard let node = node else { return true }
        
        // Traverse left
        if !inorder(node.left) {
            return false
        }
        
        // Check current node with previous
        if let prev = prev, node.data <= prev.data {
            return false
        }
        prev = node
        
        // Traverse right
        return inorder(node.right)
    }
    
    
    //Maximum Depth of Binary Tree
    //https://www.youtube.com/watch?v=hTM3phVI6YQ
    /**
     A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
     */
    func maxDepth(_ root: Node?) -> Int {
        guard let root = root else { return 0 }
        return 1 + max(maxDepth(root.left), maxDepth(root.right))
    }
    
    /**
     When using a queue (BFS approach) to find the maximum depth of a binary tree, we count the number of levels (and hence the number of nodes in the longest path from root to leaf).

     Here’s how you can do that in Swift, using a queue (level-order traversal / BFS):
     */
    func maxDepth_BFS_Approach(_ root: Node?) -> Int {
        guard let root = root else { return 0 }
        var queue = Queue<Node>()
        queue.enqueue(root)
        var level = 0
        while !queue.isEmpty {
            for i in 0..<queue.count {
                var node = queue.dequeue()
                if let left = node?.left {
                    queue.enqueue(left)
                }
                if let right = node?.right {
                    queue.enqueue(right)
                }
            }
            level += 1
        }
        return level
    }
    
    
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
    
    /*Lowest Common Ancestor (LCA) of Two Nodes
    1. In Binary search Tree
    2. In Binary tree*/
    
    /**
     Problem: Find LCA of two nodes ****in a Binary search Tree.**
     https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/
     https://www.youtube.com/watch?v=gs2LMfuOR9k
              6
            /      \
           2         8
          /   \       /  \
         0     4    7     9
            /  \
           3     5

     ✅ LCA(2, 8) → 6 (Root itself)
     ✅ LCA(2, 4) → 2 (Ancestor of 4)
     ✅ LCA(3, 5) → 4
     ✅ LCA(4, 7) → 6
     ✅ LCA(0, 5) → 2
      🛠 Approach:

      Since it's a Binary Search Tree (BST), we can use the BST properties to optimize the solution.
      Key Observations:
      If both p and q are smaller than the current node, the LCA lies in the left subtree.
      If both p and q are greater than the current node, the LCA lies in the right subtree.
      If p and q are on opposite sides or one of them is the current node, the current node is the LCA.
      Recursive Solution (O(log N) for Balanced BST, O(N) for Skewed Tree) ***/
    
     func lowestCommonAncestorInBST(_ root: Node?, _ p: Node?, _ q: Node?) -> Node? {
         guard let root = root else { return nil }
         if let p = p, let q = q {
             if p.data < root.data && q.data < root.data {
                 return lowestCommonAncestor(root.left, p, q)  // LCA in the left subtree
             } else if p.data > root.data && q.data > root.data {
                 return lowestCommonAncestor(root.right, p, q) // LCA in the right subtree
             }
         }
         return root
     }
     
     
    /*
     Problem: Find LCA of two nodes ****in a Binary Tree.***
     https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/submissions/1575793333/
     https://www.geeksforgeeks.org/lowest-common-ancestor-binary-tree-set-1/
     https://www.youtube.com/watch?v=13m9ZCB8gjw
     Time Complexity: O(N)
     ✅ Space Complexity: O(H) (Recursive Stack) */
     
    func lowestCommonAncestor(_ root: Node?, _ p: Node?, _ q: Node?) -> Node? {
        guard let root = root else { return nil }
        if root.data == p?.data || root.data == q?.data { return root }
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        if left != nil && right != nil {
            return root
        }
        return left != nil ? left : right
    }
    
    /**
     Check if a Binary Tree is Balanced
     📌 Problem: A balanced binary tree is one where the height of any two subtrees differs by at most 1. Implement a function to check if a tree is balanced.
     Solution (Bottom-Up DFS Approach):
     https://www.geeksforgeeks.org/how-to-determine-if-a-binary-tree-is-balanced/
     */
    /**A simple approach is to compute the absolute difference between the heights of the left and right subtrees for each node of the tree using DFS traversal. If, for any node, this absolute difference becomes greater than one, then the entire tree is not height-balanced.**/
    //Time Complexity: O(N^2)
    func isBalancedBinaryTree(_ root: Node?) -> Bool {
        return isBalancedHelper(root)
    }

    private func isBalancedHelper(_ root: Node?) -> Bool {
        guard let root = root else { return true }
        var lHeight = height(root.left)
        var rHeight = height(root.right)
        if abs(lHeight - rHeight) > 1 { return false}
        return isBalancedHelper(root.left) && isBalancedHelper(root.right)
    }
    
    
    /**
     The above approach can be optimised by calculating the height in the same function rather than calling a height() function separately.
     For each node make two recursion calls: one for left subtree and the other for the right subtree.
     Based on the heights returned from the recursion calls, decide if the subtree whose root is the current node is height-balanced or not.
     If it is balanced then return the height of that subtree. Otherwise, return -1 to denote that the subtree is not height-balanced.*/
    
    func isBinaryTreeBalancedOptimised(_ root: Node?) -> Bool {
        return checkHeight(root) != -1
    }

    private func checkHeight(_ root: Node?) -> Int {
        guard let root = root else { return 0 }
        let lHeight = checkHeight(root.left)
        let rHeight = checkHeight(root.right)
        if lHeight == -1 || rHeight == -1 || abs(lHeight - rHeight) > 1 {
            return -1
        }
        return max(lHeight, rHeight) + 1
    }
    
    // print all diagonals of binary tree (Iterative)
    
    func printDiagonals(_ root: Node?) {
        guard let root = root else { return }
        var queue = Queue<Node>()
        
    }
}
