//
//  TableListDetailViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class TableListDetailViewController: UIViewController {
    
    
    var listing: Listing!
    
    
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var unitNumberView: UITextView!
    @IBOutlet weak var descriptionForListingView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
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
    
    @IBOutlet weak var postingDateLabel: UILabel!
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var photos = Photos()
    
    var enlargedPictures: [Photo] = []
    
    
    let dateFormatter = DateFormatter()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enlargedPictures.removeAll()
        
        

        if listing == nil{
            listing = Listing()
        }
        print("The listing being loaded is \(listing!)")
        
        
        
        updateUserInterface()
        
        photos.loadData(listing: listing) {
            print("The photo array is \(self.photos.photoArray)")
            self.imageCollectionView.reloadData()
            
        }
        
        for pictures in photos.photoArray{
            enlargedPictures.append(pictures)
        }
        
        
        
        
        
    }
    
    
    func updateUserInterface(){
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let usableDate = listing.postingDate
        
        var dateString = dateFormatter.string(from: usableDate)
        dateString = dateFormatter.string(from: usableDate)
        postingDateLabel.text = "Date Posted: \(dateString)"
    
        
        addressTextView.text = listing.address
        unitNumberView.text = listing.unitNumber
        descriptionForListingView.text = listing.descriptionForListing
        
        if listing.price.remainder(dividingBy: 1) == 0{
            priceTextView.text = "\(listing.price)0"
        }
        else{
            priceTextView.text = "\(listing.price)"
        }
        
        if listing.utilitiesBoxBool == true{
            self.utilitiesBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.washerDryerBoxBool == true{
            self.washerDryerBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.dishwasherBoxBool == true{
                   self.dishwasherBoxImage.image = UIImage(systemName: "checkmark.rectangle")
               }
        if listing.singleRoomBoxBool == true{
            self.singleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.doubleRoomBoxBool == true{
            self.doubleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.parkingSpotBoxBool == true{
            self.parkingSpaceBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.airConditioningBoxBool == true{
            self.airConditioningBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.petsBoxBool == true{
            self.petsBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        if listing.deckBoxBool == true{
                  self.deckBoxImage.image = UIImage(systemName: "checkmark.rectangle")
              }
        if listing.handicapBoxBool == true{
            self.handicapBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        
    }
    
}

extension TableListDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "TableViewListingCollectionViewCell", for: indexPath) as! TableViewListingCollectionViewCell
        cell.imageView.image = photos.photoArray[indexPath.row].image
        return cell
    }
    

    //Use the following two functions to execute segue to separate view controller to view photos at larger size in vertical collection view

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EnlargePhotos", sender: Any?.self)
        return print("Tapped")

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnlargePhotos"{
            print("segue fired")
            let destination = segue.destination as! TestViewController
            destination.listing = listing
        }
    }
}
