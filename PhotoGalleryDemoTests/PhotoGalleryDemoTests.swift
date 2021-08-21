//
//  PhotoGalleryDemoTests.swift
//  PhotoGalleryDemoTests
//
//  Created by Mostafa.Sultan on 8/17/21.
//

import XCTest
@testable import PhotoGalleryDemo

class PhotoGalleryDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPhotosAPI() throws {
        
        let promise = expectation(description: "data retrieved!")
        var responseError: Error?
        var dataRetrieved: Bool = false
        PhotosRepository.loadPhotos() { response in
            switch response {
            case .failure(let error):
                responseError = error
            case .success(let photosResult):
                dataRetrieved = photosResult.count > 0
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertTrue(dataRetrieved)
        
    }
    
    func testCacheMaxLimit() throws {
        try XCTSkipUnless(
            !NetworkMonitor.shared.isReachable,
          "Disable Network connection to proceed this test.")
        
        let promise = expectation(description: "data retrieved!")
        var responseError: Error?
        var isWithinMaxLimit: Bool = false
        PhotosRepository.loadPhotos() { response in
            switch response {
            case .failure(let error):
                responseError = error
            case .success(let photosResult):
                isWithinMaxLimit = photosResult.count <= 20
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertTrue(isWithinMaxLimit)
    }

}
