//
//  ProjectRouter.swift
//  SwiftCairo-App
//
//  Created by abdelrahman mohamed on 4/21/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import Alamofire

enum PhotosRouter: URLRequestBuilder {
    case photos(page: Int, limit: Int)
    
    // MARK: - Path
    internal var path: String {
        switch self {
        case .photos:
            return "list"
        }
    }

    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        case let .photos(page, limit):
            params["page"] = "\(page)"
            params["limit"] = "\(limit)"
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .photos:
            return .get
        }
        
    }
}
