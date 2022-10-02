//
//  ImageListViewControllerMocks.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest

class MockImageListViewModel: ImageListViewModelProtocol {
    var viewDelegate: LightspeedImageList.ImageListViewModelDelegate?
    
    var images: [LightspeedImageList.LSImage] = []

    var fetchImagesCalled = false
    func fetchImages() {
        fetchImagesCalled = true
    }
}
