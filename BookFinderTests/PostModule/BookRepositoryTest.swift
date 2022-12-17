//
//  BookRepositoryTest.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class BookRepositoryTest: XCTestCase {
    
    var bookRepository: BookRepositoryProtocol!
    var mockBookService: MockBookService!
    
    override func setUp() {
        super.setUp()
        mockBookService = MockBookService()
        bookRepository = BookRepository(service: mockBookService)
    }
    
    override func tearDown() {
        bookRepository = nil
        mockBookService = nil
        super.tearDown()
    }

    func testBookRepository_Success() {
        let expectation = expectation(description: "Post Repository of Success Case")
        mockBookService.response = MockData.bookInfo
        
        mockBookService.fetchBooksFromNetwork(searchItem) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case let .success(response):
                if response.items.count > 0 {
                    expectation.fulfill()
                }
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testBookRepository_Failure() {
        let expectation = expectation(description: "Repositoy of Failure Case")
        mockBookService.error = NetworkError.failed

        mockBookService.fetchBooksFromNetwork(searchItem) { (result: Result<BookDataListDTO, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success not expected")
            case let .failure(error):
                XCTAssertEqual(error as! NetworkError, NetworkError.failed)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
