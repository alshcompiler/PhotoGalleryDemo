//
//  PhotosCollectionViewCell.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit
import AlamofireImage

class PhotosCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "\(PhotosCollectionViewCell.self)"
    let screenWidth = UIScreen.main.bounds.width
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    func configure(_ photo: PhotoDetails) {
        self.contentView.roundCorners()
        authorLabel.text = photo.author
        configureImage(photo)
    }
    
    fileprivate func configureImage(_ photo: PhotoDetails) {
        if photo.isAd {
            photoImageView.image = #imageLiteral(resourceName: "vodafoneAd")
        }
        else {
            guard let url = URL(string: photo.downloadURL ?? "") else {return}
            loadImage(url)
        }
    }
    
    fileprivate func loadImage(_ url: URL) {
        let filter = AspectScaledToFillSizeFilter(
            size: CGSize(width: screenWidth, height: screenWidth) // small enough for memory( images were crazily large ), large enough for details screen
        )
        photoImageView.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "galleryPlaceholder"),filter: filter)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.af.cancelImageRequest()
        photoImageView.image = nil
     }
}
