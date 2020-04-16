//
//  DetailViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/13/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var priceView: UITextField!
    @IBOutlet weak var utilitiesBoxImage: UIImageView!
    @IBOutlet weak var washerDryerBoxImage: UIImageView!
    @IBOutlet weak var dishwasherBoxImage: UIImageView!
    @IBOutlet weak var singleRoomBoxImage: UIImageView!
    @IBOutlet weak var doubleRoomBoxImage: UIImageView!
    @IBOutlet weak var parkingSpotBoxImage: UIImageView!
    @IBOutlet weak var airConditioningBoxImage: UIImageView!
    @IBOutlet weak var petsImageBox: UIImageView!
    @IBOutlet weak var deckImageBox: UIImageView!
    @IBOutlet weak var handicapImageBox: UIImageView!
    
    
    var listing: Listing!
    var listings: Listings!
    
    
    var utilitiesBoxBool = false
    var washerDryerBoxBool = false
    var dishwasherBoxBool = false
    var singleRoomBoxBool = false
    var doubleRoomBoxBool = false
    var parkingSpotBoxBool = false
    var airConditioningBoxBool = false
    var petsBoxBool = false
    var deckBoxBool = false
    var handicapBoxBool = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButton.isEnabled = false
        hideKeyboardWhenTappedAround()
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = UIColor.black.cgColor
        
        if listing == nil {
            listing = Listing()
        }
        updateUserInterface()
        

       
    }
    
    func updateUserInterface(){
        addressField.text = listing.address
        unitField.text = listing.unitNumber
        descriptionView.text = listing.descriptionForListing
        priceView.text = "\(listing.price)"
    }
    
    func updateFromUserInterface(){
        listing.address = addressField.text!
        listing.unitNumber = unitField.text!
        listing.descriptionForListing = descriptionView.text!
        listing.price = Double(priceView.text!)!
        listing.utilitiesBoxBool = utilitiesBoxBool
        listing.washerDryerBoxBool = washerDryerBoxBool
        listing.dishwasherBoxBool = dishwasherBoxBool
        listing.singleRoomBoxBool = singleRoomBoxBool
        listing.doubleRoomBoxBool = doubleRoomBoxBool
        listing.parkingSpotBoxBool = parkingSpotBoxBool
        listing.airConditioningBoxBool = airConditioningBoxBool
        listing.petsBoxBool = petsBoxBool
        listing.deckBoxBool = deckBoxBool
        listing.handicapBoxBool = handicapBoxBool
    }
    
    
    @IBAction func utilitiesBoxTapped(_ sender: UITapGestureRecognizer) {
        if utilitiesBoxBool == true {
           self.utilitiesBoxImage.image = UIImage(systemName: "rectangle")
            utilitiesBoxBool = false
        }
        else{
            self.utilitiesBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            utilitiesBoxBool = true
        }
    }
    
    
    @IBAction func washerDryerBoxTapped(_ sender: UITapGestureRecognizer) {
        if washerDryerBoxBool == true {
           self.washerDryerBoxImage.image = UIImage(systemName: "rectangle")
            washerDryerBoxBool = false
        }
        else{
            self.washerDryerBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            washerDryerBoxBool = true
        }
    }
    
    @IBAction func dishwasherBoxTapped(_ sender: UITapGestureRecognizer) {
        if  dishwasherBoxBool == true {
           self.dishwasherBoxImage.image = UIImage(systemName: "rectangle")
            dishwasherBoxBool = false
        }
        else{
            self.dishwasherBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            dishwasherBoxBool = true
        }
    }
    
    @IBAction func singleRoomBoxTapped(_ sender: UITapGestureRecognizer) {
        if  singleRoomBoxBool == true {
                  self.singleRoomBoxImage.image = UIImage(systemName: "rectangle")
                   singleRoomBoxBool = false
               }
               else{
                   self.singleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
                   singleRoomBoxBool = true
               }
    }
    
    
    @IBAction func doubleRoomBoxTapped(_ sender: UITapGestureRecognizer) {
        if  doubleRoomBoxBool == true {
           self.doubleRoomBoxImage.image = UIImage(systemName: "rectangle")
            doubleRoomBoxBool = false
        }
        else{
            self.doubleRoomBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            doubleRoomBoxBool = true
        }
    }
    
    @IBAction func parkingSpaceBoxTapped(_ sender: UITapGestureRecognizer) {
        if  parkingSpotBoxBool == true {
           self.parkingSpotBoxImage.image = UIImage(systemName: "rectangle")
            parkingSpotBoxBool = false
        }
        else{
            self.parkingSpotBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            parkingSpotBoxBool = true
        }
    }
    
    
    @IBAction func airConditioningBoxTapped(_ sender: UITapGestureRecognizer) {
        if  airConditioningBoxBool == true {
           self.airConditioningBoxImage.image = UIImage(systemName: "rectangle")
            airConditioningBoxBool = false
        }
        else{
            self.airConditioningBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            airConditioningBoxBool = true
        }
    }
    
    @IBAction func petsBoxTapped(_ sender: UITapGestureRecognizer) {
        if  petsBoxBool == true {
           self.petsImageBox.image = UIImage(systemName: "rectangle")
            petsBoxBool = false
        }
        else{
            self.petsImageBox.image = UIImage(systemName: "checkmark.rectangle")
            petsBoxBool = true
        }
    }
    
    
    @IBAction func deckBoxTapped(_ sender: UITapGestureRecognizer) {
        if  deckBoxBool == true {
           self.deckImageBox.image = UIImage(systemName: "rectangle")
            deckBoxBool = false
        }
        else{
            self.deckImageBox.image = UIImage(systemName: "checkmark.rectangle")
            deckBoxBool = true
        }
    }
    
    
    @IBAction func handicapBoxTapped(_ sender: UITapGestureRecognizer) {
        if handicapBoxBool == true {
           self.handicapImageBox.image = UIImage(systemName: "rectangle")
            handicapBoxBool = false
        }
        else{
            self.handicapImageBox.image = UIImage(systemName: "checkmark.rectangle")
            handicapBoxBool = true
        }
        
    }
    

    
    @IBAction func addressBarTapped(_ sender: UITapGestureRecognizer) {
        let autoCompleteController = GMSAutocompleteViewController()
                  autoCompleteController.delegate = self
        //present(autoCompleteController, animated: true, completion: )
        present(autoCompleteController, animated: true, completion: {
                self.saveBarButton.isEnabled = true
        } )
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func addressFieldEditingChanged(_ sender: UITextField) {
        saveBarButton.isEnabled = !(addressField.text == "")
    }
    func leaveViewController(){
           let isPresentingInAddMode = presentingViewController is UINavigationController
           if isPresentingInAddMode {
               dismiss(animated: true, completion: nil)
           }
           else{
               navigationController?.popViewController(animated: true)
           }
       }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        listing.saveData { success in
            if success {
                self.leaveViewController()
            } else {
                print("*** ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
    }
    
    

 
}

extension DetailViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        listing.address = place.formattedAddress ?? ""
        listing.coordinate = place.coordinate
        dismiss(animated: true, completion: nil)
        if addressField.text != ""{
                   saveBarButton.isEnabled = true
               }
        updateUserInterface()
        print("The listing coordinate is : \(listing.coordinate)")
        print("The posting date is: \(listing.postingDate)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("The Cancel Button for Google was pressed!")
        if self.addressField.text == "" {
            self.saveBarButton.isEnabled = false
        }
        dismiss(animated: true, completion: {
            print("The boolean value is \(self.addressField.text == "")")
            if self.addressField.text == "" {
                self.saveBarButton.isEnabled = false
            }
        })
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension DetailViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}