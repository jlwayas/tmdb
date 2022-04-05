//
//  MovieDetailState.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

class MovieDetailViewModelSpec: XCTestCase {
    
    var mockMovieService: MockMovieService!
    var viewModel: MovieDetailState!
    
    @MainActor override func setUp() {
        mockMovieService = MockMovieService()
        viewModel = .init(movieService: mockMovieService)
    }

    func test_should_make_sure_movies_are_load_and_decode() {
    }
}
