//
//  PhotosOnlineDataStore.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/19/21.
//

import Foundation

class PhotosOnlineDataStore: PhotosDataStore {
    
    private let pagingLimit: Int = 10
    static var page: Int = 1
    static var shouldPage: Bool = true
    
    func loadPhotos(result: @escaping PhotosResult) {
        if !PhotosOnlineDataStore.shouldPage {return}
        PhotosRouter.photos(page: PhotosOnlineDataStore.page, limit: pagingLimit).send(PhotosDetails.self, then: { response in
            switch response {
            case .failure(let error):
                result(.failure(error))
            case .success(let photosResult):
                PhotosOnlineDataStore.shouldPage = self.pagingLimit <= photosResult.count
                PhotosOnlineDataStore.page += 1
                result(.success(photosResult))
            }
        })
    }
}
