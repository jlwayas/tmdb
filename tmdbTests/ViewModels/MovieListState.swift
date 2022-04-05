//
//  MovieListState.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

@MainActor
class MovieListViewModelSpec: XCTestCase {
    
    var viewModel: MovieListState!
    
    func test_should_make_sure_load_movies_by_category_and_decode() async throws {
        // Given
        viewModel = .init()
        let endpoint: MovieListEndpoint = .nowPlaying
        let pageNumber: Int = 1
        // When
        await viewModel.fetchMoviesFromEndpoint(endpoint, pageNumber: pageNumber)
        // Then
        XCTAssertNotNil(viewModel.movies)
        XCTAssertEqual(20, viewModel.movies.count)
        XCTAssertEqual("", viewModel.trimmedQuery)
    }
    
    func test_should_make_sure_load_movies_by_category_and_load_next_page_movies_and_decode() async throws {
        // Given
        viewModel = .init()
        let endpoint: MovieListEndpoint = .nowPlaying
        let pageNumber: Int = 1
        // When
        await viewModel.fetchMoviesFromEndpoint(endpoint, pageNumber: pageNumber)
        await viewModel.loadNextPageMovies(from: endpoint)
        // Then
        XCTAssertNotNil(viewModel.movies)
        XCTAssertEqual(40, viewModel.movies.count)
    }
    
    func test_should_not_bring_movies_when_page_number_is_0_or_less() async throws {
        // Given
        viewModel = .init()
        let endpoint: MovieListEndpoint = .nowPlaying
        let pageNumber: Int = 0
        // When
        await viewModel.fetchMoviesFromEndpoint(endpoint, pageNumber: pageNumber)
        // Then
        XCTAssertNotNil(viewModel.movies)
        XCTAssertEqual([], viewModel.movies)
    }
    
    func test_should_user_type_text_to_searchMovies_in_category_view_in_plural_text() {
        // Given
        viewModel = .init()
        let numberMovies: Int = 100
        // When
        let counterMovies = viewModel.getCounterMovies(from: numberMovies)
        // Then
        XCTAssertNotEqual("1 video", counterMovies)
        XCTAssertEqual("100 videos", counterMovies)
    }
    
    
    func test_should_user_type_text_to_searchMovies_in_category_view_in_singular_text() {
        // Given
        viewModel = .init()
        let numberMovies: Int = 1
        // When
        let counterMovies = viewModel.getCounterMovies(from: numberMovies)
        // Then
        XCTAssertNotEqual("100 videos", counterMovies)
        XCTAssertEqual("1 video", counterMovies)
    }
    
}
