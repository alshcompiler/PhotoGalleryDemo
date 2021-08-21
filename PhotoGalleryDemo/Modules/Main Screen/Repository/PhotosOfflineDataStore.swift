//
//  PhotosOfflineDataStore.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/19/21.
//

import Foundation

class PhotosOfflineDataStore: PhotosDataStore {
    
    func loadPhotos(result: @escaping PhotosResult) {
        if let data = UserDefaults.standard.value(forKey:"cashed photos") as? Data {
            guard let photosResult = try? PropertyListDecoder().decode(PhotosDetails.self, from: data) else {return result(.success([]))}
            result(.success(photosResult))
        }
        else {
            result(.success([]))
        }
    }
}
