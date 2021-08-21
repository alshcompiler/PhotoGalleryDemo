//
//  DetailsViewController.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/18/21.
//

import UIKit

class DetailsViewController: UIViewController {
    static let storyboardID = "\(DetailsViewController.self)"
    
    @IBOutlet private weak var photoImageView: UIImageView!
    var photo: UIImage = UIImage()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        photoImageView.image = photo
        view.backgroundColor = photo.averageColor() // Objective-C version not best result
//        view.backgroundColor = photo.dominantColor // swift version , more accurate result
        
    }

}
