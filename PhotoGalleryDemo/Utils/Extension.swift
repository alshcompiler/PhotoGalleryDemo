//
//  Extension.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation
import UIKit


extension UIView {
    func roundCorners(radius: CGFloat = 16) { // default value
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
