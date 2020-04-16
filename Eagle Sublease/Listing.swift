//
//  Listing.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/13/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit


class Listing: NSObject, MKAnnotation{
    var address: String
    var coordinate: CLLocationCoordinate2D
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
        return coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var location: CLLocation{
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var dictionary: [String: Any]{
        let timeIntervalDate = postingDate.timeIntervalSince1970
        return ["address": address, "latitude": latitude, "longitude": longitude, "unitNumber": unitNumber,"descriptionForListing": descriptionForListing, "postingDate": timeIntervalDate,"index": index, "price": price, "utilitiesBoxBool": utilitiesBoxBool, "washerDryerBoxBool" : washerDryerBoxBool, "dishwasherBoxBool" : dishwasherBoxBool, "singleRoomBoxBool": singleRoomBoxBool, "doubleRoomBoxBool": doubleRoomBoxBool, "parkingSpotBoxBool": parkingSpotBoxBool, "airConditioningBoxBool": airConditioningBoxBool, "petsBoxBool": petsBoxBool, "deckBoxBool": deckBoxBool, "handicapBoxBool": handicapBoxBool, "postingUserID": postingUserID, "documentID": documentID]
    }
    
    
    init(address: String, coordinate: CLLocationCoordinate2D, unitNumber: String, descriptionForListing: String, postingDate: Date,index: Int, price:Double,utilitiesBoxBool: Bool,washerDryerBoxBool: Bool,dishwasherBoxBool: Bool,singleRoomBoxBool: Bool, doubleRoomBoxBool: Bool, parkingSpotBoxBool: Bool, airConditioningBoxBool: Bool, petsBoxBool: Bool,deckBoxBool: Bool,handicapBoxBool: Bool, postingUserID: String, documentID: String){
        self.address = address
        self.coordinate = coordinate
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
        self.init(address: "", coordinate: CLLocationCoordinate2D(), unitNumber: "", descriptionForListing: "", postingDate: Date(), index: 0, price: 0.0, utilitiesBoxBool: false, washerDryerBoxBool: false, dishwasherBoxBool: false, singleRoomBoxBool: false, doubleRoomBoxBool: false, parkingSpotBoxBool: false, airConditioningBoxBool: false, petsBoxBool: false, deckBoxBool:false, handicapBoxBool: false,postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let address = dictionary["address"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let unitNumber = dictionary["unitNumber"] as! String? ?? ""
        let descriptionForListing = dictionary["descriptionForListing"] as! String? ?? ""
        let timeIntervalDate = dictionary["postingDate"] as! TimeInterval? ?? TimeInterval()
        let index = dictionary["index"] as! Int? ?? 0
        let price = dictionary["price"] as! Double? ?? 0.0
        let utilitiesBoxBool = dictionary["utilitiesBoxBool"] as! Bool? ?? false
        let washerDryerBoxBool = dictionary["washerDryerBoxBool"] as! Bool? ?? false
        let dishwasherBoxBool = dictionary["dishwasherBoxBool"] as! Bool? ?? false
        let singleRoomBoxBool = dictionary["singleRoomBoxBool"] as! Bool? ?? false
        let doubleRoomBoxBool = dictionary["doubleRoomBoxBool"] as! Bool? ?? false
        let parkingSpotBoxBool = dictionary["parkingSpotBoxBool"] as! Bool? ?? false
        let airConditioningBoxBool = dictionary["airConditioningBoxBool"] as! Bool? ?? false
        let petsBoxBool = dictionary["petsBoxBool"] as! Bool? ?? false
        let deckBoxBool = dictionary["deckBoxBool"] as! Bool? ?? false
        let handicapBoxBool = dictionary["handicapBoxBool"] as! Bool? ?? false
        let postingDate = Date(timeIntervalSince1970: timeIntervalDate)
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        
        self.init(address: address, coordinate: coordinate, unitNumber: unitNumber, descriptionForListing: descriptionForListing, postingDate: postingDate, index: index, price: price, utilitiesBoxBool: utilitiesBoxBool, washerDryerBoxBool: washerDryerBoxBool, dishwasherBoxBool: dishwasherBoxBool, singleRoomBoxBool: singleRoomBoxBool, doubleRoomBoxBool: doubleRoomBoxBool, parkingSpotBoxBool: parkingSpotBoxBool, airConditioningBoxBool: airConditioningBoxBool, petsBoxBool: petsBoxBool, deckBoxBool: deckBoxBool, handicapBoxBool: handicapBoxBool,postingUserID: postingUserID, documentID: "" )
        
    }
    
    func saveData(completion: @escaping (Bool) -> ())  {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we HAVE saved a record, we'll have an ID
        if self.documentID != "" {
            let ref = db.collection("listing").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked!
                    completion(true)
                }
            }
        } else { // Otherwise create a new document via .addDocument
            var ref: DocumentReference? = nil // Firestore will creat a new ID for us
            ref = db.collection("listing").addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("ERROR: adding document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked! Save the documentID in listing’s documentID property
                    self.documentID = ref!.documentID
                    completion(true)
                }
            }
        }
    }
    
}



