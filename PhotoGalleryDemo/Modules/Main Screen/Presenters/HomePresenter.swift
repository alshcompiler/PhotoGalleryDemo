//
//  HomePresenter.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation

protocol HomeView: NSObjectProtocol { 
    func reloadData()
}

class HomePresenter {
    
    private weak var view: HomeView!
    
    private let maxAllowedCache: Int = 24 // calculated generated ads too
    private let pagingThreshold: Int = 2
    
    private var timer: Timer?
    
    var photos: PhotosDetails = [] {
        didSet {
            if NetworkMonitor.shared.isReachable {
                cacheData()
            }
        }
    }
    
    init(view: HomeView) {
        self.view = view
    }
    
    func getPhotos() {
        if !photos.isEmpty && !NetworkMonitor.shared.isReachable {return} // no need to load cache right? it will show exactly less than or equal to what is already on screen ;)
        PhotosRepository.loadPhotos() { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .failure(let error):
                break
                // TODO: - show some error
            case .success(let photosResult):
                self.photos.append(contentsOf: NetworkMonitor.shared.isReachable ? self.photosWithAds(photosResult) : photosResult)
                self.view.reloadData()
            }
        }
    }
    
    private func photosWithAds(_ photosResult: PhotosDetails) -> PhotosDetails {
        var result: PhotosDetails = []
        for (index, element) in photosResult.enumerated() {
            result.append(element)
            if (index + 1) % 5 == 0 { // +1 because 0 based index will add first item as an ad
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
    
    @objc private func cacheData() { // if offline return
        if photos.count <= maxAllowedCache && !photos.isEmpty {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(Array(photos.prefix(20))), forKey:"cashed photos")
        }
    }
    /// only the last time an image within the first 10 and first 20 gets downloaded + 5 seconds to give time for previous cells to download, then sync
    func scheduleCache() {
        if photos.count > maxAllowedCache {return}
        self.timer?.invalidate()  // Cancel any previous timer
        self.timer = nil
        self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.cacheData), userInfo: nil, repeats: false)
         
    }
}
