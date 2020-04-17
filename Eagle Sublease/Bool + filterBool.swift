//
//  Bool + filterBool.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/16/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation
import UIKit

extension Bool{
    func filterBool(indices : [Int], dictionary : [Int : Bool], listing: Listing) -> Bool {
        if indices.count == 0{
            return true
        }
        
        if indices.count == 1{
            return listing.(dictionary[indices[0]]!)
        }
        
        
        
        
    }
    
    
    
}
