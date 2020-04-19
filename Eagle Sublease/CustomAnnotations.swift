//
//  CustomAnnotations.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/18/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit

class CustomAnnotations: MKPointAnnotation {
    var address: String
    var coordinates: CLLocationCoordinate2D
    var unitNumber: String
    var descriptionForListing: String
    var postingDate: Date
    var index: Int
    var price: Double
    var utilitiesBoxBool: Bool
    var washerDryerBoxBool: Bool
    var dishwasherBoxBool: Bool
    var singleRoomBoxBool: Bool
    var doubleRoomBoxBool: Bool
    var parkingSpotBoxBool: Bool
    var airConditioningBoxBool: Bool
    var petsBoxBool: Bool
    var deckBoxBool: Bool
    var handicapBoxBool: Bool
    var postingUserID: String
    var documentID: String
    
    var latitude: CLLocationDegrees {
        return coordinates.latitude
    }
    
    var longitude: CLLocationDegrees {
        return coordinates.longitude
    }
    
    init(address: String, coordinates: CLLocationCoordinate2D, unitNumber: String, descriptionForListing: String, postingDate: Date,index: Int, price:Double,utilitiesBoxBool: Bool,washerDryerBoxBool: Bool,dishwasherBoxBool: Bool,singleRoomBoxBool: Bool, doubleRoomBoxBool: Bool, parkingSpotBoxBool: Bool, airConditioningBoxBool: Bool, petsBoxBool: Bool,deckBoxBool: Bool,handicapBoxBool: Bool, postingUserID: String, documentID: String){
        self.address = address
        self.coordinates = coordinates
        self.unitNumber = unitNumber
        self.descriptionForListing = descriptionForListing
        self.postingDate = postingDate
        self.index = index
        self.price = price
        self.utilitiesBoxBool = utilitiesBoxBool
        self.washerDryerBoxBool = washerDryerBoxBool
        self.dishwasherBoxBool = dishwasherBoxBool
        self.singleRoomBoxBool = singleRoomBoxBool
        self.doubleRoomBoxBool = doubleRoomBoxBool
        self.parkingSpotBoxBool = parkingSpotBoxBool
        self.airConditioningBoxBool = airConditioningBoxBool
        self.petsBoxBool = petsBoxBool
        self.deckBoxBool = deckBoxBool
        self.handicapBoxBool = handicapBoxBool
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience override init(){
        self.init(address: "", coordinates: CLLocationCoordinate2D(), unitNumber: "", descriptionForListing: "", postingDate: Date(), index: 0, price: 0.0, utilitiesBoxBool: false, washerDryerBoxBool: false, dishwasherBoxBool: false, singleRoomBoxBool: false, doubleRoomBoxBool: false, parkingSpotBoxBool: false, airConditioningBoxBool: false, petsBoxBool: false, deckBoxBool:false, handicapBoxBool: false,postingUserID: "", documentID: "")
    }
}
    
