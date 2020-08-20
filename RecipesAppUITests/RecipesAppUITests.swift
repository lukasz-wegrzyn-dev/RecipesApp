//
//  RecipesAppUITests.swift
//  RecipesAppUITests
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import XCTest

class RecipesAppUITests: XCTestCase {
    
    func testUserSearching() {
        let app = XCUIApplication()
        app.launch()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("Chicken")
        app.keyboards.buttons["Search"].tap()
        sleep(3)
        XCTAssert(app.tables.staticTexts.count > 0)
    }
    
    func testWrongPhraseUserSearching() {
        let app = XCUIApplication()
        app.launch()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("Chicken Chicken Chicken")
        app.keyboards.buttons["Search"].tap()
        sleep(3)
        XCTAssert(app.tables.staticTexts.count == 0)
    }
}
