//
//  Photos.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//


import Foundation
import Firebase


class Photos {
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
        
    }
    
}
