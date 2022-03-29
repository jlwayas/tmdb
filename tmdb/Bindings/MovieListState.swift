//
//  MovieListState.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

@MainActor
class MovieListState: ObservableObject {
    
    private let movieService: MovieService
    @Published private(set) var phase: DataFetchPhase<MovieResponse?> = .empty
    
    var movieResponse: MovieResponse? {
        phase.value ?? nil
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func fetchMoviesFromEndpoint(_ endpoint: MovieListEndpoint, pageNumber: Int) async {
        if Task.isCancelled { return }
        phase = .empty
        
        do {
            let movieResponse = try await movieService.fetchMovies(from: endpoint, pageNumber: pageNumber)
            phase = .success(movieResponse)
        } catch {
            phase = .failure(error)
        }
    }
}
