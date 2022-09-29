//
//  APIRequestProtocols.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

protocol APIClientProtocol {
    func load<R: APIRequest>(_ request: R, completion: @escaping (Result<R.Response, APIError>) -> Void)
}
