//
//  DoublyLinkedList.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 03/02/25.
//

import Foundation

class DoublyListNode {
    var value: Int
    var next: DoublyListNode?
    var prev: DoublyListNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

class DoublyLinkedList {
    var head: DoublyListNode?
    var tail: DoublyListNode?
    
    // 1️⃣ Insert newNode at the End
    func append(_ value: Int) {
        let newNode = DoublyListNode(value)
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            newNode.prev = tail
            tail = newNode
        }
    }
    
    // 2️⃣ Insert newNode at the Beginning
    func prepend(_ value: Int) {
        let newNode = DoublyListNode(value)
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        }
    }
    
    // 3️⃣ Delete a Node by Value
    func delete(_ value: Int) {
        var current = head
        while current != nil {
            
            if current?.value == value {
                
                // case 1 deleting head node
                if current === head {
                    head = current?.next
                    head?.prev = nil
                } 
                // case 2 deleting tail node
                else if current === tail {
                    tail = tail?.prev
                    tail?.next = nil
                } 
                // case 3 deleting middle node
                else {
                    current?.prev?.next = current?.next
                    current?.next?.prev = current?.prev
                }
                return
            }
            current = current?.next
        }
    }
    
   // 4️⃣ Search for a Node
    func search(_ value: Int) -> Bool {
        var current = head
        while current != nil {
            if current?.value == value {
                return true
            }
            current = current?.next
        }
        return false
    }
    
    // 6️⃣ Print the Linked List (Forward)
    func printForward() {
        var current = head
        while current != nil {
            print("\(current!.value)")
            current = current?.next
        }
    }
    
    // 7️⃣ Print the Linked List (Backward)
    func printBackward() {
        var current = tail
        while current != nil {
            print("\(current!.value)")
            current = current?.prev
        }
    }
}
