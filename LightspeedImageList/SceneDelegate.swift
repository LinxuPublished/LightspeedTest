//
//  SceneDelegate.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let lsClients : APIClient = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = 20

        let environmentConfiguration = EnvironmentConfiguration(baseURL: URL(string: EndPoint.baseURL)!,urlSessionConfiguration: urlSessionConfiguration)
        let client = APIClient(environment: environmentConfiguration)
        return client
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController()
        navigation.viewControllers = [ImageListViewController(ImageListViewModel(LSAPI(client: lsClients)))]
        let viewController = navigation
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

