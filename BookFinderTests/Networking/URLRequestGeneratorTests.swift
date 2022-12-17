//
//  URLRequestGeneratorTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class URLRequestGeneratorTests: XCTestCase {
    
    var requestGenerator: URLRequestGeneratorProtocol!
    
    override func setUp() {
        super.setUp()
        requestGenerator = URLRequestGenerator()
    }
    
    override func tearDown() {
        requestGenerator = nil
        super.tearDown()
    }
    
    func testURLRequest() {
        let request = NetworkRequest(path: "/books/v1/volumes",
                                     method: .get,
                                     headerParamaters: ["Content-Type":"application/json"])
        do {
            let urlRequest = try requestGenerator.createURLRequest(using: request)
            XCTAssertEqual(urlRequest.url?.host, "www.googleapis.com")
            XCTAssertEqual(urlRequest.url?.scheme, "https")
            XCTAssertEqual(urlRequest.url?.path, "/books/v1/volumes")
            XCTAssertEqual(urlRequest.url, URL(string: "https://www.googleapis.com/books/v1/volumes?"))
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type":"application/json"])
            XCTAssertNil(urlRequest.httpBody)
        } catch (_) {
            XCTFail("Request Failure not expected")
        }
    }
}
