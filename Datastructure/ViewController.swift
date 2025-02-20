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
        // Do any additional setup after loading the view.
        exicuteArray()
    }
    
    func exicuteArray() {
        let array = ArrayDS()
        //let value = array.subarraySum([1, 1, 1], 2)
        //let value = array.maximumSubarraySum([8,5,20,2,9], 1)
        //print(value)
        print(array.binaryGap(9))
        
    }


}

