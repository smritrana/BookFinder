//
//  NetworkManagerTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest
@testable import BookFinder

class NetworkManagerTests: XCTestCase {
    
    var networkManger: NetworkManagerProtocol!
    var mockURLSession: MockURLSession!
    
    var response: HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "/BookInfo")!,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
    }
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        networkManger = NetworkManager(session: mockURLSession)
    }

    override func tearDown() {
        networkManger = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testRequestSuccessResponse() {
        let expectation = expectation(description: "Success Response")
        mockURLSession.data = MockData.bookData
        mockURLSession.urlResponse = response
        
        let request = NetworkRequest(path: "/BookInfo", method: .get)
        networkManger.request(request: request) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case let .success(books):
                XCTAssertTrue(books.items.count == 2)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRequestFailureCase() {
        let expectation = expectation(description: "Bad Request Failure Case")
        mockURLSession.error = NSError(domain: "Failed", code: 0)
        
        let request = NetworkRequest(path: "/BookInfo", method: .get)
        networkManger.request(request: request) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expectd")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.badRequest)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testParserFailureCase() {
        let expectation = expectation(description: "Unable to Decode Failure Case")
        mockURLSession.data = Data()
        mockURLSession.urlResponse = response
        
        let request = NetworkRequest(path: "/BookInfo", method: .get)
        networkManger.request(request: request) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expectd")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.unableToDecode)
                XCTAssertEqual((error as! NetworkError).description, "Response couldnot be decoded")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testInvalidRequestFailure() {
        let expectation = expectation(description: "Invalid Request")
        
        let request = NetworkRequest(path: "(#$%", method: .get)
        networkManger.request(request: request) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidRequest)
                XCTAssertEqual((error as! NetworkError).description, "Invalid Request")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testNoResponseFailureCase() {
        let expectation = expectation(description: "No Response Failure Case")
        mockURLSession.data = MockData.bookData
        
        let request = NetworkRequest(path: "/BookInfo", method: .get)
        networkManger.request(request: request) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expectd")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.noResponse)
                XCTAssertEqual((error as! NetworkError).description, "Response returned with no response")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
