//
//  MovieService.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint, page: Int) async throws -> [Movie]
    func fetchMovie(id: Int) async throws -> Movie
    func searchMovie(query: String) async throws -> [Movie]
}

