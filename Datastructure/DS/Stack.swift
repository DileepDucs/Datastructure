//
//  Stack.swift
//  SwiftProgramming
//
//  Created by Dileep Jaiswal on 31/08/21.
//

import UIKit

struct Stack<T> {
    private var array: [T] = []
    
    mutating func push(_ element: T) {
        
        array.append(element)
    }
    
    mutating func pop() -> T? {
        
        return array.popLast()
    }
    
    func peek() -> T? {
        guard let top = array.last else { return nil }
        return top
    }
     
    var isEmpty: Bool {
        array.isEmpty
    }
}

//This is the beauty of extension where we can check generic to as specific data type(Int) or not
// ths function return sum of array using heigher order function: reduce
extension Stack where T == Int {
    var valuesSum: Int {
        return array.reduce(0, +)
    }
}

