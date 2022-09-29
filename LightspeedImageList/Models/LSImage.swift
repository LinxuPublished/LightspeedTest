//
//  LSImage.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public struct LSImage: Codable {

    // MARK: - Properties

    let id: String?
    let author: String?
    let downloadUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case downloadUrl = "download_url"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
    }
}
