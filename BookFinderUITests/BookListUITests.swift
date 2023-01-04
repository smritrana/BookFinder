//
//  BookListUITests.swift
//  BookFinderUITests
//
//  Created by Smriti Rana on 04/01/23.
//

import XCTest

class BookListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    func testOpenMovieDetails() {

        let app = XCUIApplication()

        // Search for Batman
        let searchText = "The Rose"
        app.searchFields["AccessibilityIdentifierSearch"].tap()
        if !app.keys["A"].waitForExistence(timeout: 5) {
            XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        }
        _ = app.searchFields["AccessibilityIdentifierSearch"].waitForExistence(timeout: 10)
        app.searchFields["AccessibilityIdentifierSearch"].typeText(searchText)
        app.buttons["search"].tap()

        // Tap on first result row
        app.tables.element.tap()
        // Make sure movie details view
        XCTAssertTrue(app.otherElements["AccessibilityIdentifierDetailsView"].waitForExistence(timeout: 5))
    }

    func testNavigationTitle() {
        let app = XCUIApplication()
        XCTAssertNotNil(app.navigationBars.element.title)
    }
}
