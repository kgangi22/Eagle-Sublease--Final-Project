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
    
    let bostonCollegeLocation = CLLocation(latitude: 42.335509, longitude: -71.168387)
    
    
    var listings: Listings!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        listings = Listings()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listings.loadData {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTableDetail"{
            let destination = segue.destination as! TableListDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.listing = listings.listingArray[selectedIndexPath.row]
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
    
    
    
    
    
    @IBAction func segementControlPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    
    
    

}

extension TableListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listings.listingArray.count
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
    
    
    
    
    
}
