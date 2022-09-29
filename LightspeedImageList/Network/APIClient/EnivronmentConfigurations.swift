//
//  EnvironmentConfigurations.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public struct EnvironmentConfiguration {

    public let baseURL: URL

    public let urlSessionConfiguration: URLSessionConfiguration

    public init(baseURL: URL, urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.urlSessionConfiguration = urlSessionConfiguration
    }
}
