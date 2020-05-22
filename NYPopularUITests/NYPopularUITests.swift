//
//  NYPopularUITests.swift
//  NYPopularUITests
//
//  Created by Hammoda on 5/22/20.
//  Copyright © 2020 salah. All rights reserved.
//

import XCTest

class NYPopularUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["By Jonathan Safran Foer"]/*[[".cells.staticTexts[\"By Jonathan Safran Foer\"]",".staticTexts[\"By Jonathan Safran Foer\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["The End of Meat Is Here"].buttons["Back"].tap()
    }
}
