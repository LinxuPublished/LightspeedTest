//
//  LightspeedAPIRequest.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public class LSAPI {

    /// The API client in charge of all network requests.
    private var client: APIClientProtocol

    init(client: APIClientProtocol) {
        self.client = client
    }

    func getImages(_ completion: @escaping (Result<[LSImage], APIError>) -> Void) {
        let request = GetImages()
        client.load(request, completion: completion)
    }
}
