//
//  TableListViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/14/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn

class TableListViewController: UIViewController {
    
    @IBOutlet weak var segmenetedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    let bostonCollegeLocation = CLLocation(latitude: 42.335509, longitude: -71.168387)
    
    var filterInUse = false
    
    var indices: [Int] = []
    
    var count = 0
    
   
    
   

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
  
    
    
    
    var indexDictionary: [Int: Bool]{
        [0: utilitiesFilterBoxBool, 1: washerDryerFilterBoxBool, 2: dishwasherFilterBoxBool, 3: singleRoomFilterBoxBool, 4: doubleRoomFilterBoxBool, 5: parkingSpotFilterBoxBool, 6: airConditioningFilterBoxBool, 7: petsFilterBoxBool, 8: deckFilterBoxBool, 9: handicapFilterBoxBool]
       }
       
    
    var listings: Listings!
    
    var filterCheckDictionary: [Int: Bool] =
        [0 : false, 1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false, 8: false, 9 : false]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("The index dictionary is \(indexDictionary)")
        
        listings = Listings()
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listings.loadData {
            self.count = 0
            self.tableView.reloadData()
            print("THE VIEW WAS RELOADED")
        }
        
    }
    
    
    func sortBasedOnSegmentPressed(){
        switch segmenetedControl.selectedSegmentIndex{
        case 0:
            listings.listingArray.sort(by: {$0.postingDate > $1.postingDate})
        case 1:
            listings.listingArray.sort(by: {$0.location.distance(from: bostonCollegeLocation) < $1.location.distance(from: bostonCollegeLocation)})
        case 2:
            listings.listingArray.sort(by: {$0.price < $1.price})
        default:
            print("Should not have gotten here")
        }
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTableDetail"{
            let destination = segue.destination as! TableListDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.listing = listings.listingArray[selectedIndexPath.row]
        } else if segue.identifier == "ShowFilters" {
            let destination = segue.destination as! FiltersViewController
            destination.utilitiesFilterBoxBool = utilitiesFilterBoxBool
            destination.washerDryerFilterBoxBool = washerDryerFilterBoxBool
            destination.dishwasherFilterBoxBool = dishwasherFilterBoxBool
            destination.singleRoomFilterBoxBool = singleRoomFilterBoxBool
            destination.doubleRoomFilterBoxBool = doubleRoomFilterBoxBool
            destination.parkingSpotFilterBoxBool = parkingSpotFilterBoxBool
            destination.airConditioningFilterBoxBool = airConditioningFilterBoxBool
            destination.petsFilterBoxBool = petsFilterBoxBool
            destination.deckFilterBoxBool = deckFilterBoxBool
            destination.handicapFilterBoxBool = handicapFilterBoxBool
        }
    }
    
    
    
    
    @IBAction func segementControlPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    @IBAction func unwindFromFiltersViewController(segue: UIStoryboardSegue) {
        
        indices.removeAll()
        
        let source = segue.source as! FiltersViewController
        utilitiesFilterBoxBool = source.utilitiesFilterBoxBool
        washerDryerFilterBoxBool = source.washerDryerFilterBoxBool
        dishwasherFilterBoxBool = source.dishwasherFilterBoxBool
        singleRoomFilterBoxBool = source.singleRoomFilterBoxBool
        doubleRoomFilterBoxBool = source.doubleRoomFilterBoxBool
        parkingSpotFilterBoxBool = source.parkingSpotFilterBoxBool
        airConditioningFilterBoxBool = source.airConditioningFilterBoxBool
        petsFilterBoxBool = source.petsFilterBoxBool
        deckFilterBoxBool = source.deckFilterBoxBool
        handicapFilterBoxBool = source.handicapFilterBoxBool
        
        if ((source.utilitiesFilterBoxBool == true) || (source.washerDryerFilterBoxBool == true) || (source.dishwasherFilterBoxBool == true) || (source.singleRoomFilterBoxBool == true) || (source.doubleRoomFilterBoxBool == true) || (source.parkingSpotFilterBoxBool == true) || (source.airConditioningFilterBoxBool == true) || (source.petsFilterBoxBool == true) || (source.deckFilterBoxBool == true) || (source.handicapFilterBoxBool == true)){
            filterInUse = true
        }
        else{
            filterInUse = false
        }
        if filterInUse == true{
            filterButton.image = UIImage(systemName: "line.horizontal.3.decrease.circle.fill")
            
        }
        else{
            filterButton.image = UIImage(systemName: "line.horizontal.3.decrease.circle")
        }
        
        if utilitiesFilterBoxBool == true{
            indices.append(0)
        }
        if washerDryerFilterBoxBool == true{
            indices.append(1)
        }
        if dishwasherFilterBoxBool == true{
            indices.append(2)
        }
        if singleRoomFilterBoxBool == true{
            indices.append(3)
        }
        if doubleRoomFilterBoxBool == true{
            indices.append(4)
        }
        if parkingSpotFilterBoxBool == true{
            indices.append(5)
        }
        if airConditioningFilterBoxBool == true{
            indices.append(6)
        }
        if petsFilterBoxBool == true{
            indices.append(7)
        }
        if deckFilterBoxBool == true{
            indices.append(8)
        }
        if handicapFilterBoxBool == true{
            indices.append(9)
        }
        
        //
        //        for number in 0..<listings.listingArray.count{
        //            if ((listings.listingArray[number].utilitiesBoxBool == utilitiesFilterBoxBool) && (listings.listingArray[number].dishwasherBoxBool == dishwasherFilterBoxBool) && (listings.listingArray[number].washerDryerBoxBool == washerDryerFilterBoxBool) && (listings.listingArray[number].singleRoomBoxBool == singleRoomFilterBoxBool) && (listings.listingArray[number].doubleRoomBoxBool == doubleRoomFilterBoxBool) && (listings.listingArray[number].parkingSpotBoxBool == parkingSpotFilterBoxBool) && (listings.listingArray[number].airConditioningBoxBool == airConditioningFilterBoxBool) && (listings.listingArray[number].petsBoxBool == petsFilterBoxBool) && (listings.listingArray[number].deckBoxBool == deckFilterBoxBool) && (listings.listingArray[number].handicapBoxBool == handicapFilterBoxBool)){
        //
        //                let listing = listings.listingArray[number]
        //
        //                filteredList.append(listing)
        //
        //            }
        //
        //
        //        }
        //
        //        tableView.reloadData()
        //
        //
        //
        //
    }
    
    
    
    
    
    
}

extension TableListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.listingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmenetedControl.selectedSegmentIndex == 0{
            listings.listingArray.sort(by: {$0.postingDate > $1.postingDate})
        }
        if segmenetedControl.selectedSegmentIndex == 1{
            listings.listingArray.sort(by: {$0.location.distance(from: bostonCollegeLocation) < $1.location.distance(from: bostonCollegeLocation)})
        }
        if segmenetedControl.selectedSegmentIndex == 2{
            listings.listingArray.sort(by: {$0.price < $1.price})
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let distanceInMeters = bostonCollegeLocation.distance(from: listings.listingArray[indexPath.row].location)
        let distanceString = "Distance: \( (distanceInMeters * 0.00062137).roundTo(place: 2) ) miles from campus"
        cell.textLabel?.text = listings.listingArray[indexPath.row].address
        cell.detailTextLabel?.text = distanceString
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmenetedControl.selectedSegmentIndex == 0 || segmenetedControl.selectedSegmentIndex == 1 || segmenetedControl.selectedSegmentIndex == 2{
            
            if filterInUse == true{
                if listings.listingArray[indexPath.row].utilitiesBoxBool == utilitiesFilterBoxBool{
                    filterCheckDictionary[0] = true
                }
                if listings.listingArray[indexPath.row].washerDryerBoxBool == washerDryerFilterBoxBool{
                    filterCheckDictionary[1] = true
                }
                if listings.listingArray[indexPath.row].dishwasherBoxBool == dishwasherFilterBoxBool{
                    filterCheckDictionary[2] = true
                }
                if listings.listingArray[indexPath.row].singleRoomBoxBool == singleRoomFilterBoxBool{
                    filterCheckDictionary[3] = true
                    print("3 Fired")
                }
                if listings.listingArray[indexPath.row].doubleRoomBoxBool == doubleRoomFilterBoxBool{
                    filterCheckDictionary[4] = true
                    print("4 Fired")
                }
                if listings.listingArray[indexPath.row].parkingSpotBoxBool == parkingSpotFilterBoxBool{
                    filterCheckDictionary[5] = true
                }
                if listings.listingArray[indexPath.row].airConditioningBoxBool == airConditioningFilterBoxBool{
                    filterCheckDictionary[6] = true
                }
                if listings.listingArray[indexPath.row].petsBoxBool == petsFilterBoxBool{
                    filterCheckDictionary[7] = true
                }
                if listings.listingArray[indexPath.row].deckBoxBool == deckFilterBoxBool{
                    filterCheckDictionary[8] = true
                }
                if listings.listingArray[indexPath.row].handicapBoxBool == handicapFilterBoxBool{
                    filterCheckDictionary[9] = true
                }
                
                print("For \(listings.listingArray[indexPath.row].address) the index dictionary is \(indexDictionary) and the filter check dictionary is \(filterCheckDictionary)")
                for number in 0..<indices.count{
                    if (filterCheckDictionary[indices[number]] == indexDictionary[indices[number]]){
                        if (filterCheckDictionary[indices[number]] == true){
                            count = count + 1
                        }
                    }
                }
                print("The count is \(count) for \(listings.listingArray[indexPath.row].address)")
                if count == indices.count{
                    count = 0
                    filterCheckDictionary[0] = false
                    filterCheckDictionary[1] = false
                    filterCheckDictionary[2] = false
                    filterCheckDictionary[3] = false
                    filterCheckDictionary[4] = false
                    filterCheckDictionary[5] = false
                    filterCheckDictionary[6] = false
                    filterCheckDictionary[7] = false
                    filterCheckDictionary[8] = false
                     filterCheckDictionary[9] = false
                    return 60
                }
                else{
                    count = 0
                    filterCheckDictionary[0] = false
                    filterCheckDictionary[1] = false
                    filterCheckDictionary[2] = false
                    filterCheckDictionary[3] = false
                    filterCheckDictionary[4] = false
                    filterCheckDictionary[5] = false
                    filterCheckDictionary[6] = false
                    filterCheckDictionary[7] = false
                    filterCheckDictionary[8] = false
                     filterCheckDictionary[9] = false
                    return 0
                }
                   }
            else{
                return 60
                
            }
            
        }
        else{
            return 60
        }
    
}
}
