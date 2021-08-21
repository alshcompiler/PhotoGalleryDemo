//
//  PhotosRepository.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/18/21.
//

import Foundation

typealias PhotosResult = (Result<PhotosDetails, Error>) -> Void

protocol PhotosDataStore {
    func loadPhotos(result: @escaping PhotosResult)
}

class PhotosRepository {
    
    static func loadPhotos(result: @escaping PhotosResult) {
        PhotosDataStoreFactory.dataStore().loadPhotos() { (storeResult) in
            switch storeResult {
            case .success(let events):
                result(.success(events))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    struct PhotosDataStoreFactory {
        static func dataStore() -> PhotosDataStore {
            return NetworkMonitor.shared.isReachable ? PhotosOnlineDataStore() : PhotosOfflineDataStore() // server or cached data
        }
    }
}
