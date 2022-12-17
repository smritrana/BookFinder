//
//  BookServiceTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class BookServiceTests: XCTestCase {

    var bookService: BookServiceProtocol!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        bookService = BookService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        bookService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testBookService_Success() {
        let expectation = expectation(description: "Service on Success Case")
        mockNetworkManager.response = MockData.bookInfo
        bookService.fetchBooksFromNetwork(searchItem) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case let .success(books):
                if books.items.count > 0 {
                    expectation.fulfill()
                }
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testBookService_Failure() {
        let expectation = expectation(description: "Service on Failure Case")
        mockNetworkManager.error = NSError(domain: "FailedError", code: 0)
        bookService.fetchBooksFromNetwork(searchItem) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case .failure(_):
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
