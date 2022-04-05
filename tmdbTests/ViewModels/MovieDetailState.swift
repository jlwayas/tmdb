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

    
    func test_should_make_sure_load_movie_detail_and_decode() async throws {
        // Given
        viewModel = .init()
        let id: Int = 414906
        // When
        let _ = await viewModel.loadMovie(id: id)
        // Then
        XCTAssertEqual(id, viewModel.movie?.id)
        XCTAssertEqual("The Batman", viewModel.movie?.title)
    }
    
    func test_should_make_sure_not_load_movie_detail() async throws {
        // Given
        viewModel = .init()
        let id: Int = -1
        // Then
        let _ = await viewModel.loadMovie(id: id)
        // Then
        XCTAssertEqual(nil, viewModel.movie)
    }
    
}
