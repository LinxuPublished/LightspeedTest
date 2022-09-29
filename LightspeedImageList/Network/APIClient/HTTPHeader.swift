//
//  HTTPHeader.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public struct HTTPHeader: Hashable {

    public let field: String

    public let value: String

    public init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}

extension HTTPHeader: CustomStringConvertible {
    public var description: String {
        return "\(field): \(value)"
    }
}

// MARK: - Helper methods

public extension HTTPHeader {

    static func acceptLanguage(_ value: String) -> HTTPHeader {
        return HTTPHeader(field: "Accept-Language", value: value)
    }

    static func contentType(_ value: String) -> HTTPHeader {
        return HTTPHeader(field: "Content-Type", value: value)
    }
}

