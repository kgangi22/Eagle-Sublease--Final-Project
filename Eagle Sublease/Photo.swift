//
//  Photo.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import Foundation
import Firebase

class Photo{
    var image: UIImage
    var description: String
    var postedBy: String
    var documentUUID: String
    var dictionary: [String: Any]{
        return ["description": description, "postedBy": postedBy]
    }
    
    init(image: UIImage, description: String, postedBy: String, documentUUID: String) {
        self.image = image
        self.description = description
        self.postedBy = postedBy
        self.documentUUID = documentUUID
    }
    
    convenience init(){
        let postedBy = Auth.auth().currentUser?.email ?? "unknown user"
        self.init(image: UIImage(), description: "", postedBy: postedBy, documentUUID: "")
    }
    
    convenience init(dictionary: [String: Any]){
        let description = dictionary["description"] as! String? ?? ""
        let postedBy = dictionary["postedBy"] as! String? ?? ""
        self.init(image: UIImage(), description: description, postedBy: postedBy, documentUUID: "")
    }
    
    func saveData(listing: Listing, completed: @escaping (Bool) -> ()){
        
        let db = Firestore.firestore()
        let storage = Storage.storage()
        //convert photo to data type
        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
            print("Could not convert image")
            return completed(false)
        }
        documentUUID = UUID().uuidString // generate a unique id
        let storageRef = storage.reference().child(listing.documentID).child(self.documentUUID)
        let uploadTask = storageRef.putData(photoData)
        
        uploadTask.observe(.success) { (snapshot) in
            
            let dataToSave = self.dictionary

                let ref = db.collection("listing").document(listing.documentID).collection("photos").document(self.documentUUID)
                ref.setData(dataToSave){ (error) in
                    if let error = error {
                        print("** Error: updating document")
                        completed(false)
                    } else{
                        completed(true)
                    }
                }
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error{
                print("Error: upload task for file failed")
            }
            return completed(false)
        }
        
        
    }
}
