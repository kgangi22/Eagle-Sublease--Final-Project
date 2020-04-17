//
//  PhotosCollectionViewCell.swift
//  Eagle Sublease
//
//  Created by Kyle Gangi on 4/17/20.
//  Copyright © 2020 Kyle Gangi. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo!{
        didSet{
            photoImageView.image = photo.image
        }
    }
}
