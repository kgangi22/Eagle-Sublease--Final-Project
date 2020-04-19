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
    
    
    
    var listing: Listing!
    var photos = Photos()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos.loadData(listing: listing) {

            print("The array of pictures to enlarge is \(self.photos.photoArray)")
        }
        
        
        print("The listing for the enlarged controller is \(listing.address)")
        
    
    }
    
}



