//
//  MovieListState.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import Combine
import SwiftUI

@MainActor
class MovieListState: ObservableObject {
    
    private let movieService: MovieService
    @Published var currentPage: Int = 1
    @Published var moviesFiltered: [Movie] = [Movie]()
    @Published var query = ""
    @Published private(set) var phase: DataFetchPhase<[Movie]> = .empty
    @Published private(set) var isFetchingNextPage: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var movies: [Movie] {
        phase.value ?? []
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func fetchMoviesFromEndpoint(_ endpoint: MovieListEndpoint, pageNumber: Int) async {
        if Task.isCancelled { return }
        phase = .empty
        
        do {
            let movieResponse = try await movieService.fetchMovies(from: endpoint, page: pageNumber)
            phase = .success(movieResponse)
            
        } catch {
            phase = .failure(error)
        }
    }
    
    func getCounterMovies(from totalMovies: Int) -> String {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else { return "\(totalMovies) video\(totalMovies > 1 ? "s" : "")" }
        
        return "\(moviesFiltered.count) video\(moviesFiltered.count > 1 ? "s" : "")"
    }
    
    func loadNextPageMovies(from endpoint: MovieListEndpoint) async {
        if Task.isCancelled { return }
        currentPage += 1
        var movies = self.phase.value ?? []
        
        do {
            let nextMvoies = try await movieService.fetchMovies(from: endpoint, page: currentPage)
            if Task.isCancelled { return }
            
            movies += nextMvoies
            
            phase = .success(movies)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func search(query: String) async {
        if Task.isCancelled { return }
        self.moviesFiltered = [Movie]()
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else { return }
        
        DispatchQueue.main.async {
            let moviesFiltered = self.movies.filter{ $0.title.localizedCaseInsensitiveContains(trimmedQuery) }
            if Task.isCancelled { return }
            guard trimmedQuery == self.trimmedQuery else { return }
            self.moviesFiltered = moviesFiltered
            
        }
    }
    
    func startObserve() {
        guard cancellables.isEmpty else { return }
        $query
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.phase = .success(self.movies)
            }
            .store(in: &cancellables)

        $query
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { query in
                Task { [weak self] in
                    guard let self = self else { return }
                    await self.search(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
}
