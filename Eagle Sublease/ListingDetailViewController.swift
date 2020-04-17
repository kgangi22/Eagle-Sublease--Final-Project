//
//  ListingDetailViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import MapKit


class ListingDetailViewController: UIViewController {
    
    
    @IBOutlet weak var addressView: UITextView!
    @IBOutlet weak var unitNumberView: UITextView!
    @IBOutlet weak var descriptionForListingView: UITextView!
    @IBOutlet weak var priceView: UITextView!
    @IBOutlet weak var postingDateLabel: UILabel!
    
    var event = Int()
    var address = String()
    var unit = String()
    var descriptionForListing = String()
    var price = Double()
    var postingDate = Date()
    var utilitiesBoxBool = Bool()
    var washerDryerBoxBool = Bool()
    var dishwasherBoxBool = Bool()
    var singleRoomBoxBool = Bool()
    var doubleRoomBoxBool = Bool()
    var parkingSpotBoxBool = Bool()
    var airConditioningBoxBool = Bool()
    var petsBoxBool = Bool()
    var deckBoxBool = Bool()
    var handicapBoxBool = Bool()
    
    
    @IBOutlet weak var utilitiesBoxImage: UIImageView!
    @IBOutlet weak var washerDryerBoxImage: UIImageView!
    @IBOutlet weak var dishwasherBoxImage: UIImageView!
    @IBOutlet weak var singleRoomBoxImage: UIImageView!
    @IBOutlet weak var doubleRoomBoxImage: UIImageView!
    @IBOutlet weak var parkingSpaceBoxImage: UIImageView!
    @IBOutlet weak var airConditioningBoxImage: UIImageView!
    @IBOutlet weak var petsBoxImage: UIImageView!
    @IBOutlet weak var deckBoxImage: UIImageView!
    @IBOutlet weak var handicapBoxImage: UIImageView!
    
     let dateFormatter = DateFormatter()
    
    
    var listings: Listings!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    func updateUserInterface(){
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let usableDate = postingDate
        
        var dateString = dateFormatter.string(from: usableDate)
        dateString = dateFormatter.string(from: usableDate)
        postingDateLabel.text = "Date Posted: \(dateString)"
        
        
        addressView.text = address
        unitNumberView.text = unit
        descriptionForListingView.text = descriptionForListing
        if price.remainder(dividingBy: 1) == 0{
            priceView.text = "\(price)0"
        }
        else{
            priceView.text = "\(price)"
        }
        if utilitiesBoxBool == true{
            self.utilitiesBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if washerDryerBoxBool == true{
            self.washerDryerBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if dishwasherBoxBool == true{
                   self.dishwasherBoxImage.image = UIImage(systemName: "checkmark.rectangle")
               }
        if singleRoomBoxBool == true{
            self.singleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if doubleRoomBoxBool == true{
            self.doubleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if parkingSpotBoxBool == true{
            self.parkingSpaceBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if airConditioningBoxBool == true{
            self.airConditioningBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if petsBoxBool == true{
            self.petsBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if deckBoxBool == true{
                  self.deckBoxImage.image = UIImage(systemName: "checkmark.rectangle")
              }
        if handicapBoxBool == true{
            self.handicapBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        
        
    }
    
    
    
    
}
