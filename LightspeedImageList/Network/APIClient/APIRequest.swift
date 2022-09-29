//
//  APIRequest.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public protocol APIRequest {

    associatedtype Response: Decodable

    var method: HTTPMethod { get }

    var path: String { get }

    var body: Data? { get }

    var contentType: HTTPHeader? { get }

    var timeoutInterval: TimeInterval? { get }
}

extension APIRequest {

    var body: Data? { return nil }

    var contentType: HTTPHeader? { return nil }

    var timeoutInterval: TimeInterval? { return nil }
}
