//
//  BookListViewModelTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class BookListViewModelTests: XCTestCase {
    
    var viewModel: BookListViewModelType!
    var mockBookUseCase: MockBookUseCase!

    override func setUp() {
        super.setUp()
        mockBookUseCase = MockBookUseCase()
        viewModel = BookListViewModel(useCase: mockBookUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockBookUseCase = nil
        super.tearDown()
    }
    
    func testSuccessScenario() {
        mockBookUseCase.bookInfo = MockData.bookList
        let waitExpectation = expectation(description: "Waiting")

        viewModel.input.fetchResults(searchItemTestValue)
        XCTAssertTrue(self.viewModel.output.bookInfo.count == 2)
        waitExpectation.fulfill()
        waitForExpectations(timeout: 1.0)
    }

    func testErrorScenario() {
        mockBookUseCase.error = NSError(domain: "Failed_Error", code: 0)
        viewModel.input.fetchResults(searchItemTestValue)
        
        XCTAssertTrue(viewModel.output.bookInfo.count == 0)
    }

    func test_getScreenName() {
        XCTAssertNotNil(viewModel.output.getScreenName)
        XCTAssertTrue(viewModel.output.getScreenName == "Book Finder")
    }

    func test_getAlertMessage() {
        XCTAssertNotNil(viewModel.output.getAlertMessage)
        XCTAssertNotNil(viewModel.output.getAlertMessage.title)
        XCTAssertTrue(viewModel.output.getAlertMessage.title == "Alert!")
        XCTAssertNotNil(viewModel.output.getAlertMessage.message)
        XCTAssertTrue(viewModel.output.getAlertMessage.message == "No book available")
    }
}
