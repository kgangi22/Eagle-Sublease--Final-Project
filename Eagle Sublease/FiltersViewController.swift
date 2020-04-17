//
//  FiltersViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/16/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    
    
    @IBOutlet weak var utilitiesFilterBoxImage: UIImageView!
    @IBOutlet weak var washerDryerFilterBoxImage: UIImageView!
    @IBOutlet weak var dishwasherFilterBoxImage: UIImageView!
    @IBOutlet weak var singleRoomFilterBoxImage: UIImageView!
    @IBOutlet weak var doubleRoomFilterBoxImage: UIImageView!
    @IBOutlet weak var parkingSpotFilterBoxImage: UIImageView!
    @IBOutlet weak var airConditioningFilterBoxImage: UIImageView!
    @IBOutlet weak var petsFilterImageBox: UIImageView!
    @IBOutlet weak var deckFilterImageBox: UIImageView!
    @IBOutlet weak var handicapFilterImageBox: UIImageView!
    
    
    
    var utilitiesFilterBoxBool = false
    var washerDryerFilterBoxBool = false
    var dishwasherFilterBoxBool = false
    var singleRoomFilterBoxBool = false
    var doubleRoomFilterBoxBool = false
    var parkingSpotFilterBoxBool = false
    var airConditioningFilterBoxBool = false
    var petsFilterBoxBool = false
    var deckFilterBoxBool = false
    var handicapFilterBoxBool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUserInterface()
        
    }
    
    func updateUserInterface(){
        
        if utilitiesFilterBoxBool == true {
            self.utilitiesFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.utilitiesFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if washerDryerFilterBoxBool == true {
            self.washerDryerFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.washerDryerFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if dishwasherFilterBoxBool == true {
            self.dishwasherFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.dishwasherFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if singleRoomFilterBoxBool == true {
            self.singleRoomFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.singleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if doubleRoomFilterBoxBool == true {
            self.doubleRoomFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.doubleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if parkingSpotFilterBoxBool == true {
            self.parkingSpotFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.parkingSpotFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if airConditioningFilterBoxBool == true {
            self.airConditioningFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.airConditioningFilterBoxImage.image = UIImage(systemName: "rectangle")
        }
        
        if petsFilterBoxBool == true {
            self.petsFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.petsFilterImageBox.image = UIImage(systemName: "rectangle")
        }
        
        if deckFilterBoxBool == true {
            self.deckFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.deckFilterImageBox.image = UIImage(systemName: "rectangle")
        }
        
        if handicapFilterBoxBool == true {
            self.handicapFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
        }
        else{
            self.handicapFilterImageBox.image = UIImage(systemName: "rectangle")
        }
    }
    
    @IBAction func utilitiesBoxTapped(_ sender: UITapGestureRecognizer) {
        
        if utilitiesFilterBoxBool == true {
            self.utilitiesFilterBoxImage.image = UIImage(systemName: "rectangle")
            utilitiesFilterBoxBool = false
        }
        else{
            self.utilitiesFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            utilitiesFilterBoxBool = true
        }
    }
    
    
    @IBAction func washerDryerBoxTapped(_ sender: UITapGestureRecognizer) {
        if washerDryerFilterBoxBool == true {
            self.washerDryerFilterBoxImage.image = UIImage(systemName: "rectangle")
            washerDryerFilterBoxBool = false
        }
        else{
            self.washerDryerFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            washerDryerFilterBoxBool = true
        }
    }
    
    @IBAction func dishwasherBoxTapped(_ sender: UITapGestureRecognizer) {
        if dishwasherFilterBoxBool == true {
            self.dishwasherFilterBoxImage.image = UIImage(systemName: "rectangle")
            dishwasherFilterBoxBool = false
        }
        else{
            self.dishwasherFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            dishwasherFilterBoxBool = true
        }
    }
    
    @IBAction func singleRoomBoxTapped(_ sender: UITapGestureRecognizer) {
        if singleRoomFilterBoxBool == true {
            self.singleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
            singleRoomFilterBoxBool = false
        }
        else{
            self.singleRoomFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            singleRoomFilterBoxBool = true
        }
    }
    
    @IBAction func doubleRoomBoxTapped(_ sender: UITapGestureRecognizer) {
        if doubleRoomFilterBoxBool == true {
            self.doubleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
            doubleRoomFilterBoxBool = false
        }
        else{
            self.doubleRoomFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            doubleRoomFilterBoxBool = true
        }
    }
    
    @IBAction func parkingSpaceBoxTapped(_ sender: UITapGestureRecognizer) {
        
        if parkingSpotFilterBoxBool == true {
            self.parkingSpotFilterBoxImage.image = UIImage(systemName: "rectangle")
            parkingSpotFilterBoxBool = false
        }
        else{
            self.parkingSpotFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            parkingSpotFilterBoxBool = true
        }
    }
    
    
    @IBAction func airconditioningBoxTapped(_ sender: UITapGestureRecognizer) {
        if airConditioningFilterBoxBool == true {
            self.airConditioningFilterBoxImage.image = UIImage(systemName: "rectangle")
            airConditioningFilterBoxBool = false
        }
        else{
            self.airConditioningFilterBoxImage.image = UIImage(systemName: "checkmark.rectangle")
            airConditioningFilterBoxBool = true
        }
    }
    
    
    
    @IBAction func petsBoxTapped(_ sender: UITapGestureRecognizer) {
        if petsFilterBoxBool == true {
            self.petsFilterImageBox.image = UIImage(systemName: "rectangle")
            petsFilterBoxBool = false
        }
        else{
            self.petsFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
            petsFilterBoxBool = true
        }
    }
    
    
    
    @IBAction func deckBoxTapped(_ sender: UITapGestureRecognizer) {
        if deckFilterBoxBool == true {
            self.deckFilterImageBox.image = UIImage(systemName: "rectangle")
            deckFilterBoxBool = false
        }
        else{
            self.deckFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
            deckFilterBoxBool = true
        }
    }
    
    @IBAction func handicapBoxTapped(_ sender: UITapGestureRecognizer) {
        if handicapFilterBoxBool == true {
            self.handicapFilterImageBox.image = UIImage(systemName: "rectangle")
            handicapFilterBoxBool = false
        }
        else{
            self.handicapFilterImageBox.image = UIImage(systemName: "checkmark.rectangle")
            handicapFilterBoxBool = true
        }
        
    }
    
    @IBAction func clearFIltersButtonPressed(_ sender: UIButton) {
        self.handicapFilterImageBox.image = UIImage(systemName: "rectangle")
        self.deckFilterImageBox.image = UIImage(systemName: "rectangle")
        self.petsFilterImageBox.image = UIImage(systemName: "rectangle")
        self.airConditioningFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.parkingSpotFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.doubleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.singleRoomFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.dishwasherFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.washerDryerFilterBoxImage.image = UIImage(systemName: "rectangle")
        self.utilitiesFilterBoxImage.image = UIImage(systemName: "rectangle")
        
        utilitiesFilterBoxBool = false
        washerDryerFilterBoxBool = false
        dishwasherFilterBoxBool = false
        singleRoomFilterBoxBool = false
        doubleRoomFilterBoxBool = false
        parkingSpotFilterBoxBool = false
        airConditioningFilterBoxBool = false
        petsFilterBoxBool = false
        deckFilterBoxBool = false
        handicapFilterBoxBool = false
        
        
    }
    
}
