//
//  BookDetailUITests.swift
//  BookFinderUITests
//
//  Created by Smriti Rana on 04/01/23.
//

import XCTest

class BookDetailUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testNavigationTitle() {
        let app = XCUIApplication()
        XCTAssertNotNil(app.navigationBars.element.title)
    }

    func testBackButton() {
        let app = XCUIApplication()
        _ = app.navigationBars["Book Finder"].descendants(matching: .button).element(boundBy: 2).exists
        app.navigationBars.element.tap()
        // Make sure movie details view
        XCTAssertTrue(app.otherElements["AccessibilityIdentifierListView"].waitForExistence(timeout: 5))
    }

    func testCellData() {
        let app = XCUIApplication()
        XCTAssertNotNil(app.tables.element.staticTexts)
    }
}
