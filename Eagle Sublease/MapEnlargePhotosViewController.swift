//
//  MapEnlargePhotosViewController.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/19/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class MapEnlargePhotosViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var listing: Listing!
    var photos = Photos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos.loadData(listing: listing) {

        print("The array of pictures to enlarge is \(self.photos.photoArray)")
        self.imageCollectionView.reloadData()

    }
        print("The listing for the enlarged controller is \(listing.address)")
               
    }
    



}

extension MapEnlargePhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "MapEnlargePhotosCollectionViewCell", for: indexPath) as! MapEnlargePhotosCollectionViewCell
        cell.imageView.image = photos.photoArray[indexPath.row].image
        return cell
    }
}

extension MapEnlargePhotosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
