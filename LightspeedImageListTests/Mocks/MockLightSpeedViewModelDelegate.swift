//
//  MockLightSpeedViewModelDelegate.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest


class MockImageListViewModelDelegate: ImageListViewModelDelegate {
    var fetchImagesSuccessDidCall = false
    func fetchImagesSuccess() {
        fetchImagesSuccessDidCall = true
    }
    
    var fetchImagesFailureDidCall = false
    func fetchImagesFailure() {
        fetchImagesFailureDidCall = true
    }
}
