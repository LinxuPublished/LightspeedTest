//
//  ViewControllerXCTestSetup.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

import UIKit
import XCTest

class ViewControllerXCTestSetup {

    private var rootWindow: UIWindow!

    func setUp(withViewController viewController: UIViewController) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = viewController
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }

    func tearDown() {
        guard let rootWindow = rootWindow,
            let rootViewController = rootWindow.rootViewController else {
                XCTFail("tearDown() was called without setUp() being called first")
                return
        }
        rootViewController.viewWillDisappear(false)
        rootViewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }
}
