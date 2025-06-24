//
//  MinStack.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 25/05/25.
//

/**
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

 Implement the MinStack class:

 MinStack() initializes the stack object.
 void push(int val) pushes the element val onto the stack.
 void pop() removes the element on the top of the stack.
 int top() gets the top element of the stack.
 int getMin() retrieves the minimum element in the stack.
 You must implement a solution with O(1) time complexity for each function.
 
 https://leetcode.com/problems/min-stack/description/
 */
struct MinStack {
    
    private var array = [Int]()
    private var minArray = [Int]()
    
    mutating func push(_ element: Int) {
        array.append(element)
        if minArray.isEmpty || element <= minArray.last! {
            minArray.append(element)
        }
    }
    
    mutating func pop() -> Int? {
        let last = array.popLast()
        if last == minArray.last {
            minArray.removeLast()
        }
        return last
    }
    
    func peek() -> Int? {
        return array.last
    }
    
    func getMin() -> Int? {
        return minArray.last
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
}
