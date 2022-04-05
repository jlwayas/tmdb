//
//  MovieSearchState.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

@MainActor
class MovieSearchViewModelSpec: XCTestCase {
    
    var viewModel: MovieSearchState!
    
    func test_should_make_sure_movies_are_load_and_decode() async throws {
        viewModel = .init()
        let query: String = "Batman"
        
        let _ = await viewModel.search(query: query)
        
        XCTAssertNotNil(viewModel.movies)
    }
    
    
    func test_should_make_sure_movies_are_load_and_decode2() async throws {
        viewModel = .init()
        let query: String = "[]"
        
        let _ = await viewModel.search(query: query)
        
        XCTAssertNotNil(viewModel.movies)
    }
    
    func test_should_make_sure_movies_are_load_and_decode3() async throws {
        viewModel = .init()
        let query: String = ""
        
        let _ = await viewModel.search(query: query)
        
        XCTAssertNotNil(viewModel.movies)
    }
}
