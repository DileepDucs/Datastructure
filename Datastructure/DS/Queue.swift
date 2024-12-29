//
//  Queue.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 29/12/24.
//

import Foundation

struct Queue<T> {
    
    private var array = [T]()
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        return array.removeFirst()
    }
    
    func peak() -> T? {
        return array.first
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
}
