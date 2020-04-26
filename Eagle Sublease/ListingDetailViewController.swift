//
//  ListingDetailViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseUI
import GoogleSignIn
import MessageUI




class ListingDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure:")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    

    @IBOutlet weak var addressView: UITextView!
    @IBOutlet weak var unitNumberView: UITextView!
    @IBOutlet weak var descriptionForListingView: UITextView!
    @IBOutlet weak var priceView: UITextView!
    @IBOutlet weak var postingDateLabel: UILabel!
    
    //    var event = Int()
    //    var address = String()
    //    var unit = String()
    //    var descriptionForListing = String()
    //    var price = Double()
    //    var postingDate = Date()
    //    var utilitiesBoxBool = Bool()
    //    var washerDryerBoxBool = Bool()
    //    var dishwasherBoxBool = Bool()
    //    var singleRoomBoxBool = Bool()
    //    var doubleRoomBoxBool = Bool()
    //    var parkingSpotBoxBool = Bool()
    //    var airConditioningBoxBool = Bool()
    //    var petsBoxBool = Bool()
    //    var deckBoxBool = Bool()
    //    var handicapBoxBool = Bool()
    
    
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
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var contactOrDeleteButton: UIBarButtonItem!
    
    
    
    
    
    var listing: Listing!
    var photos = Photos()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionForListingView.layer.borderWidth = 1
        descriptionForListingView.layer.borderColor = UIColor.black.cgColor
        
        if listing == nil{
            listing = Listing()
        }
        
        print("The listing sent over was \(listing.address)")
        updateUserInterface()
        
        print("The listing is \(listing)")
        print("The listing document ID is \(listing.documentID)")
        
        photos.loadData(listing: listing) {
            print("The photo array is \(self.photos.photoArray)")
            self.imageCollectionView.reloadData()
            
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
        
        
        addressView.text = listing.address
        unitNumberView.text = listing.unitNumber
        descriptionForListingView.text = listing.descriptionForListing
        if listing.price.remainder(dividingBy: 1) == 0{
            priceView.text = "\(listing.price)0"
        }
        else{
            priceView.text = "\(listing.price)"
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
            
            deleteAlert(title: "Are You Sure You Want To Delete", message: "This action cannot be undone.")
            
        
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func deleteAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            self.listing.deleteData(listing: self.listing) { (success) in
            if success {
                self.leaveViewController()
            } else {
              print("*** Error: delete unsuccessful")
            }
        }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
}

extension ListingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MapListingDetailCollectionViewCell", for: indexPath) as! MapListingDetailCollectionViewCell
        cell.imageView.image = photos.photoArray[indexPath.row].image
        return cell
    }
    
    
    //Use the following two functions to execute segue to separate view controller to view photos at larger size in vertical collection view
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MapEnlargePhoto", sender: Any?.self)
        return print("Tapped")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapEnlargePhoto"{
            print("segue fired")
            let destination = segue.destination as! MapEnlargePhotosViewController
            destination.listing = listing
        }
    }
}

