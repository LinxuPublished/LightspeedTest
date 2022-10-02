//
//  APIMock.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest

class MockEmptyApiClient: APIClientProtocol {
    func load<R: APIRequest>(_ request: R, completion: @escaping (Result<R.Response, APIError>) -> Void) {
        XCTFail("Should not be called \(request.path)")
    }
}

class MockLSAPI: LSAPI {
    
    init() {
        super.init(client: MockEmptyApiClient())
    }

    var error: APIError?
    var images: [LSImage]?

    override func getImages(_ completion: @escaping (Result<[LSImage], APIError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let result = images {
            completion(.success(result))
        }
    }
}
