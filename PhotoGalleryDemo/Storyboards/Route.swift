//
//  Route.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/21/21.
//

import Foundation

extension UIStoryboard {
    enum Storyboard: String {
        case main 

        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) { // lets us make easier secondary initializer that eventually calls init
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
            
            guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }
            
            return viewController
        }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    
}

extension UIViewController: StoryboardIdentifiable { }
