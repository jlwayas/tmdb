//
//  RetryView.swift
//  tmdbUITests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

class when_app_is_launched: XCTestCase {
    
    func test_should_display_retryView() {
        
        let app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        continueAfterFailure = false
        app.launch()
        
        let quizList = app.tables["quizList"]
        XCTAssertEqual(2, quizList.cells.count)
    }
   
}
