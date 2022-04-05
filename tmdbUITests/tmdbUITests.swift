//
//  tmdbUITests.swift
//  tmdbUITests
//
//  Created by Jesùs Wayas on 02/04/22.
//

import XCTest

@testable import tmdb
class when_app_is_launched: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_should_display_available_movies() {
        let movieList = app.tables["movieList"]
        XCTAssertEqual(4, movieList.cells.count)
    }

    func test_should_display_empty_placeholder_in_search_view() {
        
        let tabBar = app/*@START_MENU_TOKEN@*/.tabBars["Tab Bar"]/*[[".otherElements[\"tabCOntainer\"].tabBars[\"Tab Bar\"]",".tabBars[\"Tab Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tabBar.buttons["Search"].tap()
        
        let emptyPlaceholder = app.staticTexts["Search your favourite movie"]
        XCTAssertTrue(emptyPlaceholder.exists)
        
    }
    
    func test_should_display_empty_view_in_search_view() {
        let tabBar = app/*@START_MENU_TOKEN@*/.tabBars["Tab Bar"]/*[[".otherElements[\"tabCOntainer\"].tabBars[\"Tab Bar\"]",".tabBars[\"Tab Bar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tabBar.buttons["Search"].tap()
        
        let searchNavigationBar = app.navigationBars["Search"]
        searchNavigationBar.searchFields["Search movie"].tap()
        searchNavigationBar.typeText("fghj")
                
        let _ = app.tabBars["Tab Bar"].waitForExistence(timeout: 5.0)
        XCTAssertTrue(app.staticTexts["No results"].exists)
        
    }

}
