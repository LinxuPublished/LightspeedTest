//
//  GetImages.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

struct GetImages: APIRequest {
    typealias Response = [LSImage]

    var method: HTTPMethod = .get

    var path = "/v2/list"
}
