//
//  APIResponse.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public protocol EmptyResponse {
    static func emptyValue() -> Self
}

public struct Empty: Decodable {
    public static let value = Empty()
}

extension Empty: EmptyResponse {
    public static func emptyValue() -> Empty {
        return value
    }
}
