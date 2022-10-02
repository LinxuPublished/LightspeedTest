//
//  ModelTest.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

@testable import LightspeedImageList
import XCTest

class ModelsTests: XCTestCase {
    
    var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }
    
    func testFullImage() throws {
        let data = try loadData(for: "images.json")
        let images = try jsonDecoder.decode([LSImage].self, from: data)
        
        XCTAssertFalse(images.isEmpty)
        
        let image = try XCTUnwrap(images.first, "image not found")
        
        XCTAssertEqual(image.id, "12")
        XCTAssertEqual(image.author, "Lightspeed")
        XCTAssertEqual(image.downloadUrl, "www.apple.com")
    }
}
