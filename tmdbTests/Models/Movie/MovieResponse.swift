//
//  MovieResponse.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//

import Foundation
import XCTest
@testable import tmdb

class when_loading_movies: XCTestCase {

    func test_should_make_sure_movies_are_load_and_decode() {
        // Given
        var movies: [Movie] = []
        // When
        movies = Movie.stubbedMovies
        // Then
        XCTAssertEqual(20, movies.count)
    }
    
    func test_should_make_sure_movie_is_load_and_decode() {
        // Given
        var movie: Movie? = nil
        // When
        movie = Movie.stubbedMovie
        // Then
        XCTAssertEqual("The Batman", movie!.title)
    }
    
    func test_should_make_sure_movie_images_url_are_valid() {
        // Given
        var movie: Movie? = nil
        let baseURL: String = "https://image.tmdb.org/t/p/w500/"
        // When
        movie = Movie.stubbedMovie
        // Then
        XCTAssertEqual(URL(string: "\(baseURL)5P8SmMzSNYikXpxil6BYzJ16611.jpg"), movie!.backdropURL)
        XCTAssertEqual(URL(string: "\(baseURL)74xTEgt7R36Fpooo50r9T25onhq.jpg"), movie!.posterURL)
    }
    
    func test_should_make_sure_movie_images_url_are_not_valid() {
        // Given
        var movie: Movie? = nil
        let baseURL: String = "https://image.tmdb.org/t/p/w500"
        // When
        movie = Movie.stubbedMovieWithError
        // Then
        XCTAssertEqual(URL(string: baseURL), movie!.backdropURL)
        XCTAssertEqual(URL(string: baseURL), movie!.posterURL)
    }
    
    func test_should_make_sure_movie_complementary_texts_are_valid() {
        // Given
        var movie: Movie? = nil
        // When
        movie = Movie.stubbedMovie
        // Then
        XCTAssertEqual("Crime", movie!.genreText)
        XCTAssertEqual("★★★★★★★", movie!.ratingText)
        XCTAssertEqual("★★★", movie!.negativeRatingText)
        XCTAssertEqual("7/10", movie!.scoreText)
        XCTAssertEqual("2022", movie!.yearText)
        XCTAssertEqual("2 horas y 56 minutos", movie!.durationText)
    }
    
    func test_should_make_sure_movie_complementary_texts_are_notvalid() {
        // Given
        var movie: Movie? = nil
        // When
        movie = Movie.stubbedMovieWithError
        // Then
        XCTAssertEqual("n/a", movie!.genreText)
        XCTAssertEqual("n/a", movie!.scoreText)
        XCTAssertEqual("n/a", movie!.yearText)
        XCTAssertEqual("n/a", movie!.durationText)
    }
    
    func test_should_make_sure_movie_complementary_arrays_are_valid() {
        // Given
        var movie: Movie? = nil
        // When
        movie = Movie.stubbedMovie
        // Then
        XCTAssertNotNil(movie?.cast)
        XCTAssertEqual(80, movie?.cast?.count)
        XCTAssertNotNil(movie?.crew)
        XCTAssertEqual(149, movie?.crew?.count)
        XCTAssertNotNil(movie?.directors)
        XCTAssertEqual(1, movie?.directors?.count)
        XCTAssertNotNil(movie?.producers)
        XCTAssertEqual(2, movie?.producers?.count)
        XCTAssertNotNil(movie?.screenWriters)
        XCTAssertEqual(0, movie?.screenWriters?.count)
        XCTAssertNotNil(movie?.youtubeTrailers)
        XCTAssertEqual(6, movie?.youtubeTrailers?.count)
    }
    
}

