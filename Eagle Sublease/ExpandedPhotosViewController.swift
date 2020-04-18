//
//  ExpandedPhotosViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class ExpandedPhotosViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var student = ""
        
        if student == nil{
            student = ""
        }
        else{
            nameLabel.text = student
        }

    }
    

   
}
