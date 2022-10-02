//
//  ImageListViewModelTests.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest

class ImageListViewModelTests: XCTestCase {
    private var viewModel: ImageListViewModel!
    private var viewModelDelegateMock: MockImageListViewModelDelegate!
    private var mockLSAPI: MockLSAPI!
    
    private var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }

    override func setUp() {
        super.setUp()
        mockLSAPI = MockLSAPI()

        viewModel = ImageListViewModel(mockLSAPI)
        viewModelDelegateMock = MockImageListViewModelDelegate()
        viewModel.viewDelegate = viewModelDelegateMock
    }

    override func tearDown() {
        viewModelDelegateMock = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchImageSuccess() throws {
        let data = try loadData(for: "images.json")
        let images = try jsonDecoder.decode([LSImage].self, from: data)
        
        mockLSAPI.images = images
        
        
        XCTAssertFalse(viewModelDelegateMock.fetchImagesSuccessDidCall)
        viewModel.fetchImages()
        
        let expectation = XCTestExpectation(description: "fetch images")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.viewModelDelegateMock.fetchImagesSuccessDidCall)
            XCTAssertFalse(self.viewModelDelegateMock.fetchImagesFailureDidCall)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchImageFailure() {        
        mockLSAPI.error = APIError.notFound
        
        XCTAssertFalse(viewModelDelegateMock.fetchImagesFailureDidCall)
        viewModel.fetchImages()
        let expectation = XCTestExpectation(description: "fetch images")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.viewModelDelegateMock.fetchImagesSuccessDidCall)
            XCTAssertTrue(self.viewModelDelegateMock.fetchImagesFailureDidCall)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}
