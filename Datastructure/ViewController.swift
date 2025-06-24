//
//  ViewController.swift
//  Datastructure
//
//  Created by Dileep Jaiswal on 28/06/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let tree = Tree()
        //tree.isBinaryTreeBalancedOptimised(<#T##root: Tree.Node?##Tree.Node?#>)
        //let array = ArrayDS()
        //array.minEatingSpeed([3,6,7,11], 8)
        tries()
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

