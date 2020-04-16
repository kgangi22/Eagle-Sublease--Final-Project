//
//  Double + RoundTo.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation


extension Double{
    func roundTo(place: Int) -> Double{
        let tenToPower = pow(10.0, Double((place >= 0 ? place: 0)))
        let roundedValue = (self * tenToPower).rounded() / tenToPower
        return roundedValue
    }
}
