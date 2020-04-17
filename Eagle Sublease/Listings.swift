//
//  Listings.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/13/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class Listings{
    var listingArray: [Listing] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    func loadData(completed: @escaping () -> ())  {
        db.collection("listing").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.listingArray = []
            // there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents {
              // You'll have to be sure you've created an initializer in the singular class (Spot, below) that acepts a dictionary.
                let listing = Listing(dictionary: document.data())
                listing.documentID = document.documentID
                self.listingArray.append(listing)
            }
            completed()
        }
    }
}
