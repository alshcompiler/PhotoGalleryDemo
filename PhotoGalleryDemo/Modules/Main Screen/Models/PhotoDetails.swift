//
//  PhotoDetails.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation
// MARK: - PhotoDetails

struct PhotoDetails: Codable, CodableInit {
    let id, author: String?
    let url, downloadURL: String?
    let width, height: Int?
    var isAd: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
    
    private init (id: String, author: String, isAd: Bool = true) {
        self.id = id
        self.author = author
        self.width = 0
        self.height = 0
        self.url = ""
        self.downloadURL = ""
        self.isAd = isAd
    }
    static func generateAd()  -> PhotoDetails {
        return PhotoDetails(id: "-1", author: "Vodafone")
    }
}

typealias PhotosDetails = [PhotoDetails]
