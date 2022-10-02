//
//  XCTestCase+Extension.swift
//  LightspeedImageListTests
//
//  Created by Lin Xu on 2022-10-02.
//

import XCTest

enum TestError: Error {
    case invalidResourceFilename
}

extension XCTestCase {
    
    func loadData(for filename: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: filename, withExtension: nil) else {
            throw TestError.invalidResourceFilename
        }
        
        return try Data(contentsOf: url)
    }
}
