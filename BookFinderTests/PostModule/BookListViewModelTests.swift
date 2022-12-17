//
//  BookListViewModelTests.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class BookListViewModelTests: XCTestCase {
    
    var viewModel: BookListInputViewModel!
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
        viewModel.fetchResults(searchItem)
        
        XCTAssertTrue(viewModel.bookInfo.count == 0)
    }

    func testErrorScenario() {
        mockBookUseCase.error = NSError(domain: "Failed_Error", code: 0)
        viewModel.fetchResults(searchItem)
        
        XCTAssertTrue(viewModel.bookInfo.count == 0)
    }
}
