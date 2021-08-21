//
//  DetailsRouter.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/21/21.
//

import Foundation

protocol DetailsRoute {
    func instantiate(image: UIImage) -> DetailsViewController
}

extension DetailsRoute where Self: UIViewController {
    func instantiate(image: UIImage) -> DetailsViewController {
        let storyboard = UIStoryboard(storyboard: .main) 
        let viewController: DetailsViewController = storyboard.instantiateViewController()
        viewController.photo = image
        return viewController
    }
}
