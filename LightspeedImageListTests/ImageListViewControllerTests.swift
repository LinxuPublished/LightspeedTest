//
//  ImageListViewControllerTests.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest

class ImageListViewControllerTests: XCTestCase {
    private var viewController: ImageListViewController!
    private var viewControllerXCTestSetup: ViewControllerXCTestSetup!
    private var viewModel: MockImageListViewModel!

    override func setUp() {
        super.setUp()

        viewModel = MockImageListViewModel()
        viewController = ImageListViewController(viewModel)

        viewControllerXCTestSetup = ViewControllerXCTestSetup()
        viewControllerXCTestSetup.setUp(withViewController: viewController)
    }

    override func tearDown() {
        viewController = nil
        viewControllerXCTestSetup.tearDown()
        viewControllerXCTestSetup = nil
        super.tearDown()
    }

    func testFetchImages() {
        XCTAssertFalse(viewModel.fetchImagesCalled)

        viewController.addImage()

        XCTAssertTrue(viewModel.fetchImagesCalled)
    }
}

