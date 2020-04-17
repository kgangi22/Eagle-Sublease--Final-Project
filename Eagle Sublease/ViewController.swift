//
//  ViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/13/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn
import MapKit

class ViewController: UIViewController {
    
    var authUI: FUIAuth!
    var listings: Listings!
    let regionDistance: CLLocationDistance = 350
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var width: Double = 3
    var height: Double = 3
    
    var indexClass = IndexClass()
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        listings = Listings()
        
        mapSetUpForViewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listings.loadData {
            self.mapView.reloadInputViews()
            self.updateMap()
            
            
        }
        
    }
    
    func mapSetUpForViewDidLoad(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
        checkLocationServices()
        centerViewOnUserLocation()
    }
    
    func accountForDuplicates() -> Bool{
        var count = 0
        for number in 0..<listings.listingArray.count{
            for index in 0..<listings.listingArray.count{
                if listings.listingArray[index].address == listings.listingArray[number].address{
                    count = count + 1
                }
            }
        }
        if count > listings.listingArray.count{
            return true
        }
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    func updateMap(){
        
        mapView.removeAnnotations(mapView.annotations)
        print("This is the array: \(listings.listingArray)")
        
        for number in 0..<listings.listingArray.count{
            listings.listingArray[number].index = number
        }
        
        
        for index in 0..<listings.listingArray.count{
            let annotation = Listing(address: listings.listingArray[index].address, coordinate: listings.listingArray[index].coordinate, unitNumber: listings.listingArray[index].unitNumber, descriptionForListing: listings.listingArray[index].descriptionForListing, postingDate: listings.listingArray[index].postingDate, index: listings.listingArray[index].index, price: listings.listingArray[index].price, utilitiesBoxBool: listings.listingArray[index].utilitiesBoxBool, washerDryerBoxBool: listings.listingArray[index].washerDryerBoxBool, dishwasherBoxBool: listings.listingArray[index].dishwasherBoxBool, singleRoomBoxBool: listings.listingArray[index].singleRoomBoxBool, doubleRoomBoxBool: listings.listingArray[index].doubleRoomBoxBool, parkingSpotBoxBool: listings.listingArray[index].parkingSpotBoxBool, airConditioningBoxBool: listings.listingArray[index].airConditioningBoxBool, petsBoxBool: listings.listingArray[index].petsBoxBool, deckBoxBool: listings.listingArray[index].deckBoxBool, handicapBoxBool: listings.listingArray[index].handicapBoxBool, postingUserID: listings.listingArray[index].postingUserID, documentID: listings.listingArray[index].documentID)
            mapView.addAnnotation(annotation)
            mapView.setCenter(listings.listingArray[index].coordinate, animated: true)
        }
        
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            print(region.center.latitude.distance(to: region.center.longitude))
            print("This is the region")
            print(region.span.latitudeDelta)
            print(region.span.longitudeDelta)
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    
    @IBAction func goToListButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ListViewSegue", sender: UIBarButtonItem.self)
    }
    
    
    @IBAction func currentLocationButtonPressed(_ sender: UIBarButtonItem) {
        centerViewOnUserLocation()
    }
    
    @IBAction func properiesNearBCPressed(_ sender: UIBarButtonItem) {
        let location = CLLocationCoordinate2D(latitude: 42.335630, longitude: -71.168507)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        print(region.center.latitude.distance(to: region.center.longitude))
        print("This is the region")
        print(region.span.latitudeDelta)
        print(region.span.longitudeDelta)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try authUI!.signOut()
            print("^^^ Successfully signed out!")
            mapView.isHidden = true
            signIn()
        } catch {
            mapView.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        } else{
            DispatchQueue.main.async{
                self.oneButtonAlert(title: "User Has Not Allowed Location Services", message: "To enable Location Services, go to the Settings App, select Privacy > Location Services > On")
            }
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            DispatchQueue.main.async{
                self.oneButtonAlert(title: "User Has Not Allowed Location Services", message: "To enable Location Services, go to the Settings App, select Privacy > Location Services, find Eagle Sublease and select While Using App")
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            DispatchQueue.main.async{
                self.oneButtonAlert(title: "User Has Not Allowed Location Services", message: "Disable restriction on Location Services")
            }
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("Error. Should not have gotten here")
        }
    }
    
    // VITAL: This gist includes key changes to make sure "cancel" works with iOS 13.
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
        ]
        if authUI.auth?.currentUser == nil {
            self.authUI?.providers = providers
            let loginViewController = authUI.authViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
        } else {
            mapView.isHidden = false
        }
    }
    
    
    
    
    
}

extension ViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            // Assumes data will be isplayed in a tableView that was hidden until login was verified so unauthorized users can't see data.
            mapView.isHidden = false
            print("^^^ We signed in with the user \(user.email ?? "unknown e-mail")")
        }
    }
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        // Create an instance of the FirebaseAuth login view controller
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        
        // Set background color to white
        loginViewController.view.backgroundColor = UIColor(red: 126/255, green: 30/255, blue: 21/255, alpha: 1.0)
        loginViewController.view.tintColor = UIColor(red: 126/255, green: 30/255, blue: 21/255, alpha: 1.0)
        print("***Attempted to Change Background Color***")
        
        // Create a frame for a UIImageView to hold our logo
        let marginInsets: CGFloat = 16 // logo will be 16 points from L and R margins
        let imageHeight: CGFloat = 225 // the height of our logo
        let imageY = self.view.center.y - imageHeight // places bottom of UIImageView in the center of the login screen
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets*2), height: imageHeight)
        
        // Create the UIImageView using the frame created above & add the "logo" image
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit // Set imageView to Aspect Fit
        loginViewController.view.addSubview(logoImageView) // Add ImageView to the login controller's main view
        return loginViewController
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func getLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            showAlertToPrivacySetting(title: "User has not authorized location services", message: "Select 'Settings' below to open device settings and enable location services")
        case .restricted:
            showAlert(title: "Location services denied", message: "Parental controls may be resticting this app")
        @unknown default:
            showAlert(title: "Location services denied", message: "Parental controls may be resticting this app")
        }
        
    }
    
    func showAlertToPrivacySetting(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else{
            print("Something went wrong")
            return
        }
        let settingsActions = UIAlertAction(title: "Settings", style: .default) { value in
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(settingsActions)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get Users Location")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

extension ViewController: MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let postAnnotation = view.annotation as? Listing else {
            return
        }
        let post = listings.listingArray[postAnnotation.index]
        print("The index number is \(post.index)")
        indexClass.index = post.index
        indexClass.address = post.address
        indexClass.descriptionForListing = post.descriptionForListing
        indexClass.unit = post.unitNumber
        indexClass.price = post.price
        indexClass.postingDate = post.postingDate
        indexClass.utilitiesBoxBool = post.utilitiesBoxBool
        indexClass.washerDryerBoxBool = post.washerDryerBoxBool
        indexClass.dishwasherBoxBool = post.dishwasherBoxBool
        indexClass.singleRoomBoxBool = post.singleRoomBoxBool
        indexClass.doubleRoomBoxBool = post.doubleRoomBoxBool
        indexClass.parkingSpotBoxBool = post.parkingSpotBoxBool
        indexClass.airConditioningBoxBool = post.airConditioningBoxBool
        indexClass.petsBoxBool = post.petsBoxBool
        indexClass.deckBoxBool = post.deckBoxBool
        indexClass.handicapBoxBool = post.handicapBoxBool
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            let destination = segue.destination as! ListingDetailViewController
            destination.event = indexClass.index
            destination.address = indexClass.address
            destination.unit = indexClass.unit
            destination.descriptionForListing = indexClass.descriptionForListing
            destination.price = indexClass.price
            destination.postingDate = indexClass.postingDate
            destination.utilitiesBoxBool = indexClass.utilitiesBoxBool
            destination.washerDryerBoxBool = indexClass.washerDryerBoxBool
            destination.dishwasherBoxBool = indexClass.dishwasherBoxBool
            destination.singleRoomBoxBool = indexClass.singleRoomBoxBool
            destination.doubleRoomBoxBool = indexClass.doubleRoomBoxBool
            destination.parkingSpotBoxBool = indexClass.parkingSpotBoxBool
            destination.airConditioningBoxBool = indexClass.airConditioningBoxBool
            destination.petsBoxBool = indexClass.petsBoxBool
            destination.deckBoxBool = indexClass.deckBoxBool
            destination.handicapBoxBool = indexClass.handicapBoxBool
            
            
        }
    }
    
    
    
    
    
}















