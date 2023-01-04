//
//  BookDetailViewModelTest.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 22/12/22.
//

import XCTest

@testable import BookFinder

class BookDeatilViewModelTests: XCTestCase {

    var viewModel: BookDetailViewModelType!
    var mockBookUseCase: MockBookUseCase!

    override func setUp() {
        super.setUp()
        mockBookUseCase = MockBookUseCase()
        mockBookUseCase.bookInfo = MockData.bookList
        let volumeInfo = mockBookUseCase.bookInfo?.items.first?.volumeInfo
        let deatilInfo = BookViewModelMapper(title: volumeInfo?.title ?? "",
                                             subTitle: volumeInfo?.subtitle ?? "",
                                             smallImageUrl: volumeInfo?.imageLinks.smallThumbnail ?? "",
                                             imageUrl: volumeInfo?.imageLinks.thumbnail ?? "",
                                             authors: volumeInfo?.authors.first ?? "",
                                             publisher: volumeInfo?.publisher ?? "",
                                             publishedDate: volumeInfo?.publishedDate ?? "",
                                             volumeInfoDescription: volumeInfo?.volumeInfoDescription ?? ""
        )
        viewModel = BookDetailViewModel(deatilInfo)
    }

    override func tearDown() {
        viewModel = nil
        mockBookUseCase = nil
        super.tearDown()
    }

    func test_bookInfo() {
        XCTAssertNotNil(viewModel.output.bookInfo)
        XCTAssertNotNil(viewModel.output.bookInfo.title)
        XCTAssertNotNil(viewModel.output.bookInfo.subTitle)
        XCTAssertNotNil(viewModel.output.bookInfo.smallImageUrl)
        XCTAssertNotNil(viewModel.output.bookInfo.imageUrl)
        XCTAssertNotNil(viewModel.output.bookInfo.authors)
        XCTAssertNotNil(viewModel.output.bookInfo.publisher)
        XCTAssertNotNil(viewModel.output.bookInfo.publishedDate)
        XCTAssertNotNil(viewModel.output.bookInfo.volumeInfoDescription)
    }

    func test_getScreenName() {
        XCTAssertNotNil(viewModel.output.getScreenName)
        XCTAssertTrue(viewModel.output.getScreenName == "Detail")
    }

    func test_getNumberOfRows() {
        let getDetailData = viewModel.output.checkForValues()
        XCTAssertTrue(viewModel.output.getNumberOfRows() == getDetailData.count)
    }

    func test_checkForValues() {
        let getDetailData = viewModel.output.checkForValues()
        XCTAssertTrue(DetailCellType.allCases.count == getDetailData.count)
    }

    func test_getSectionType() {
        let getSectionData0 = viewModel.output.getSectionType(.title)
        XCTAssertTrue(getSectionData0.0 == DetailCellType.title)
        XCTAssertNotNil(getSectionData0.value)

        let getSectionData1 = viewModel.output.getSectionType(.subTitle)
        XCTAssertTrue(getSectionData1.0 == DetailCellType.subTitle)
        XCTAssertNotNil(getSectionData1.value)

        let getSectionData2 = viewModel.output.getSectionType(.publisher)
        XCTAssertTrue(getSectionData2.0 == DetailCellType.publisher)
        XCTAssertNotNil(getSectionData2.value)

        let getSectionData3 = viewModel.output.getSectionType(.published)
        XCTAssertTrue(getSectionData3.0 == DetailCellType.published)
        XCTAssertNotNil(getSectionData3.value)

        let getSectionData4 = viewModel.output.getSectionType(.volumeInfo)
        XCTAssertTrue(getSectionData4.0 == DetailCellType.volumeInfo)
        XCTAssertNotNil(getSectionData4.value)
    }
}
