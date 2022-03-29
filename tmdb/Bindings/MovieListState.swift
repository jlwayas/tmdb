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
    @Published var query = ""
    @Published private(set) var phase: DataFetchPhase<[Movie]> = .empty
    @Published private(set) var phaseFilter: DataFetchPhase<[Movie]> = .empty
    private var cancellables = Set<AnyCancellable>()
    
    private let pagingData = PagingData(itemsPerPage: 21, maxPageLimit: 1)
    
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var movies: [Movie] {
        phase.value ?? []
    }
    
    var moviesFiltered: [Movie] = [Movie]()
    
//    var nextPage: Int { currentPage + 1 }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
//    func fetchMoviesFirstPage(from endpoint: MovieListEndpoint, pageNumber: Int) async {
//        if Task.isCancelled { return }
//        phase = .empty
//
//        do {
//            await pagingData.reset()
//            let movies = try await pagingData.loadNextPage(dataFetchProvider: loadMovies(from:, page: ))
//
//            phase = .success(articles)
//        } catch {
//            if Task.isCancelled { return }
//            print(error.localizedDescription)
//            phase = .failure(error)
//        }    }
    
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
    
//    private func loadMovies(from endpoint: MovieListEndpoint, page: Int) async throws -> MovieResponse? {
//        let movieResponse = try await movieService.fetchMovies(
//            from: endpoint,
//            page: page
//        )
//        if Task.isCancelled { return nil }
//        return movieResponse
//    }
    
    func search(query: String) async {
        if Task.isCancelled { return }
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else { return }
        print(movies.filter{ $0.title.localizedCaseInsensitiveContains(trimmedQuery) }.count)
        let moviesFiltered = movies.filter{ $0.title.localizedCaseInsensitiveContains(trimmedQuery) }
        
        if Task.isCancelled { return }
        guard trimmedQuery == self.trimmedQuery else { return }
        self.moviesFiltered = moviesFiltered
    }
    
    func startObserve() {
        guard cancellables.isEmpty else { return }
        $query
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sink { [weak self] _ in
                self?.moviesFiltered = self?.movies ?? []
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
