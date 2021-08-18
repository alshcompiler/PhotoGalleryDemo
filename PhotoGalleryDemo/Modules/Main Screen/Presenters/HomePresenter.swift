//
//  HomePresenter.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation

protocol HomeView: AnyObject { // so that we can make a weak instance
    func reloadData()
}

class HomePresenter {
    
    weak var view: HomeView!
    
    var photos: PhotosDetails = []
    
    let pagingLimit: Int = 10
    var page: Int = 1
    var shouldPage: Bool = true
    let pagingThreshold: Int = 2
    
    init(view: HomeView) {
        self.view = view
    }
    
    func getPhotos() {
        if !shouldPage {return}
        PhotosRouter.photos(page: page, limit: pagingLimit).send(PhotosDetails.self, then: { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .failure(let error):
                // TODO: - show some error
                print(error)
            case .success(let photosResult):
                print(photosResult)
                self.shouldPage = self.pagingLimit <= photosResult.count
                self.page += 1
                self.photos.append(contentsOf: self.photosWithAds(photosResult))
                self.view.reloadData()
            }
        })
    }
    
    private func photosWithAds(_ photosResult: PhotosDetails) -> PhotosDetails {
        var result: PhotosDetails = []
        for (index, element) in photosResult.enumerated() {
            result.append(element)
            if (index + 1) % 5 == 0 { // +1 because 0 based will add first item as an ad
                result.append(PhotoDetails.generateAd())
            }
        }
        return result
    }
    
    func goNextPage(index: Int) {
        if index + pagingThreshold == photos.count { // to start paging before reaching last cell 
            getPhotos()
        }
    }
}
