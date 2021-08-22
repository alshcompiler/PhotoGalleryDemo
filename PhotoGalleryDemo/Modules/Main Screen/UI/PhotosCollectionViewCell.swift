//
//  PhotosCollectionViewCell.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import UIKit
import AlamofireImage

protocol CacheCellImageDelegate: NSObjectProtocol {
    func syncPhotosCache() 
}

class PhotosCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "\(PhotosCollectionViewCell.self)"
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let maxCacheIndex: Int = 19 // 0 based
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    weak var cacheCellImageDelegate: CacheCellImageDelegate?
    
    func configure(_ photo: PhotoDetails, _ index: Int, _ delegate: CacheCellImageDelegate) {
        self.contentView.roundCorners()
        cacheCellImageDelegate = delegate
        configureImage(photo, index)
        authorLabel.text = photo.author
    }
    
    fileprivate func configureImage(_ photo: PhotoDetails, _ index: Int) {
        if photo.isAd {
            photoImageView.image = #imageLiteral(resourceName: "vodafoneAd")
            if index > maxCacheIndex {return} // no need to store image data right?
            photo.imageData = #imageLiteral(resourceName: "vodafoneAd").jpegData(compressionQuality: 1) ?? Data() // to store the image of the ad as well
        }
        else {
            loadImage(photo, index)
        }
    }
    
    fileprivate func loadImage(_ photo: PhotoDetails, _ index: Int) {
        if !NetworkMonitor.shared.isReachable {
            let imageData: Data = photo.imageData ?? Data()
            photoImageView.image = imageData.isEmpty ? #imageLiteral(resourceName: "galleryPlaceholder") : UIImage(data: imageData) // set placeholder if image was not cached
            return
        }
        guard let url = URL(string: photo.downloadURL ?? "") else {return}
        
        let filter: AspectScaledToFillSizeFilter = AspectScaledToFillSizeFilter(
            // small enough for memory( images were crazily large ), large enough for details screen
            size: CGSize(width: screenWidth, height: screenWidth)
        )
        photoImageView.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "galleryPlaceholder"),filter: filter, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false) { [weak self] image in
            
            guard let self = self else {return}
            if index <= self.maxCacheIndex { // no need to store image data after 20 right? 
                guard let imageData =  image.value?.jpegData(compressionQuality: 1) else {return} // first time only for every image otherwise it returns nil
                // chose jpegData since it's faster than pngData, didn't use image.data directly since it has the large image data not the cropped one
                photo.imageData = imageData
                self.cacheCellImageDelegate?.syncPhotosCache()
            }
        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.af.cancelImageRequest()
        photoImageView.image = nil
     }
}
