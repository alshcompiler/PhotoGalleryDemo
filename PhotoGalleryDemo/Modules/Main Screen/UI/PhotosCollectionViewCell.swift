//
//  PhotosCollectionViewCell.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "\(PhotosCollectionViewCell.self)"
    let adRecurringIndex: Double = 5.0 // after every 5 photos
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func configure(index: Int) {
        photoImageView.roundCorners()
        if isAd(index: index) {
            photoImageView.image = #imageLiteral(resourceName: "vodafoneAd")
        }
        else {
            photoImageView.image = #imageLiteral(resourceName: "galleryPlaceholder")
        }
    }
    
    private func isAd(index: Int) -> Bool {
        return Double(index) / adRecurringIndex == 1.0
    }
}
