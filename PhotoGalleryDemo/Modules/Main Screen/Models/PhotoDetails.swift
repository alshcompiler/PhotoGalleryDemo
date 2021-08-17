//
//  PhotoDetails.swift
//  PhotoGalleryDemo
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import Foundation
// MARK: - PhotoDetails

struct PhotoDetails: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
