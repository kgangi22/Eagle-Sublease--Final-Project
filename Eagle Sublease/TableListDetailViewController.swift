//
//  TableListDetailViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class TableListDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
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
    
    
    @IBOutlet weak var contactOrDeleteButton: UIBarButtonItem!
    
    var photos = Photos()
    
    var enlargedPictures: [Photo] = []
    
    
    let dateFormatter = DateFormatter()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enlargedPictures.removeAll()
        
        descriptionForListingView.layer.borderWidth = 1
        descriptionForListingView.layer.borderColor = UIColor.black.cgColor
        
        

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
        
        let currentUserID = Auth.auth().currentUser?.uid ?? "unknown user"
        
        print("The current posting user id is \(currentUserID)")
        
        if currentUserID == listing.postingUserID {
            contactOrDeleteButton.title = "Delete"
            contactOrDeleteButton.tintColor = .red
        }
        else{
            contactOrDeleteButton.title = "Contact"
            
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
    
    func leaveViewController(){
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func contactOrDeleteButtonPressed(_ sender: UIBarButtonItem) {
        
        
        if contactOrDeleteButton.title == "Contact"{
            
            if MFMailComposeViewController.canSendMail() {
                let mailComposeViewController = MFMailComposeViewController()
                
                mailComposeViewController.setToRecipients(["\(listing.postedBy)"])
                mailComposeViewController.setSubject("\(listing.address)")
                
                mailComposeViewController.mailComposeDelegate = self
                
                present(mailComposeViewController, animated: true, completion: nil)
                
            }
            else{
                print("Mail services are not available")
                oneButtonAlert(title: "Message Service Not Enabled", message: "Message services may not be enabled on this device. You must have a mailbox set up in your mail application.")
                print("Tried to send email to \(listing.postedBy)")
            }
            
        }
        else{
            listing.deleteData(listing: listing) { (success) in
                if success {
                    self.leaveViewController()
                } else {
                  print("*** Error: delete unsuccessful")
                }
            }
        }
    
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
