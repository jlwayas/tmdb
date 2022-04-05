//
//  MockMovieService.swift
//  tmdbTests
//
//  Created by Jesùs Wayas on 04/04/22.
//
import Foundation
@testable import tmdb
import XCTest
//
//final class MockMovieService: MovieService {
//    
//    private let apiKey = "dc1852cd28f729c2920cdfe05225cbfb"
//    private let baseAPIURL = "https://api.themoviedb.org/3"
//    private let urlSession = URLSession.shared
//    private let jsonDecoder = Utils.jsonDecoder
//    
//    func fetchAllMovies(from endpoint: MovieListEndpoint) async throws -> MovieResponse {
//        
//        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
//            throw MovieError.invalidEndpoint
//        }
//        
//        
//        
//        let movieResponse: MovieResponse = try await self.loadURLAndDecode(url: url)
//        return movieResponse
//    }
//    
//    func fetchMovies(from endpoint: MovieListEndpoint, page: Int) async throws -> [Movie] {
//        
//    }
//    
//    func fetchMovie(id: Int) async throws -> Movie {
//        
//    }
//    
//    func searchMovie(query: String) async throws -> [Movie] {
//        
//    }
//    
//    
//}
