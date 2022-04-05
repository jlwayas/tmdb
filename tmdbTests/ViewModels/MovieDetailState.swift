//
//  MovieDetailState.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

@MainActor
class MovieDetailViewModelSpec: XCTestCase {
    
    var viewModel: MovieDetailState!

    
    func test_should_make_sure_movies_are_load_and_decode() async throws {
        viewModel = .init()
        let id: Int = 414906
        
        let _ = await viewModel.loadMovie(id: id)
        
        XCTAssertEqual(id, viewModel.movie?.id)
        XCTAssertEqual("The Batman", viewModel.movie?.title)
    }
    
    func test_should_make_sure_movies_are_load_and_decode2() async throws {
        viewModel = .init()
        let id: Int = -1
        
        let _ = await viewModel.loadMovie(id: id)
        
        XCTAssertEqual(nil, viewModel.movie)
    }
    
}
