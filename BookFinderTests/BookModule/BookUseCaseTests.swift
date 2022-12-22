//
//  BookUseCaseTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class BookUseCaseTests: XCTestCase {
    
    var bookUseCase: BookUseCaseProtocol!
    var mockBookRepository: MockBookRepository!

    override func setUp() {
        super.setUp()
        mockBookRepository = MockBookRepository()
        bookUseCase = BookUseCase(respository: mockBookRepository)
    }
    
    override func tearDown() {
        bookUseCase = nil
        mockBookRepository = nil
        super.tearDown()
    }
    
    func testBookUseCaseSuccess() {
        let expeectation = expectation(description: "Success Case")
        mockBookRepository.bookInfo = MockData.domainBooks
        
        bookUseCase.fetchBookList(searchItemTestValue) { (result: Result<BookInfo, Error>) in
            switch result {
            case let .success(books):
                XCTAssertTrue(books.items.count == 2)
                expeectation.fulfill()
            case .failure(_):
                XCTFail("Failure not expected")
            }
        }
        wait(for: [expeectation], timeout: 2.0)
    }
    
    func testBookUseCaseFailure() {
        let expectation = expectation(description: "Failure Case")
        mockBookRepository.error = NSError(domain: "Failed_Error", code: 0)
        
        bookUseCase.fetchBookList(searchItemTestValue) { (result: Result<BookInfo, Error>) in
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
