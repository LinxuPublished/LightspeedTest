//
//  APIError.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public enum APIError: Error, Equatable {
    case requestError(description: String)
    case invalidResponse
    case invalidRequest
    case unacceptableStatusCode(code: Int)
    case responseDataNilOrZeroLength
    case invalidEmptyResponse(type: String)
    case decodingFailed
    case notFound
}
