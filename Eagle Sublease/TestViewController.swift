//
//  TestViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    //This is a test view controller- delete for final version

    @IBOutlet weak var nameLabel: UILabel!
    
    var student: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if student == nil{
            student = ""
        }
        
        nameLabel.text = student
        
    }
    

    

}
