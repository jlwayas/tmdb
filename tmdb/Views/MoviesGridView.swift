//
//  MoviesGridView.swift
//  tmdb
//
//  Created by user213150 on 3/28/22.
//

import SwiftUI

struct MoviesGridView: View {
    
    let title: String
    let totalResults: Int
    let endpoint: MovieListEndpoint
    @StateObject private var movieListState = MovieListState()
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        List {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    Section(header: headerView(totalResults: totalResults)) {
                        ForEach(movieListState.query == "" ? movieListState.movies : movieListState.moviesFiltered) { movie in
                                if movie == movieListState.movies.last {
                                    Text("\(movie.title)")
                                } else {
                                    NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                                            MovieThumbnailView(movie: movie, thumbnailType: .gridItem)
                                                .frame(height: 224)
                                        }
                                        .buttonStyle(.plain)
                                }
                            }
                        }
                    }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .onAppear{ movieListState.startObserve() }
        .navigationBarTitle(title, displayMode: .inline)
        .overlay(
            DataFetchPhaseOverlayView(phase: movieListState.phase, retryAction: loadFirstPageMovies)
        )
        .refreshable { resetPages() }
        .searchable(text: $movieListState.query, prompt: "Search movie")
        .task { loadFirstPageMovies() }
    }
    
    func headerView (totalResults: Int) -> some View {
        return HStack {
            Text("\(totalResults) videos")
                .font(.system(.headline, design: .rounded))
                .padding()
            Spacer()
        }
    }
    
    @Sendable
    private func loadFirstPageMovies () {
        Task {
            await self.movieListState.fetchMoviesFromEndpoint(endpoint, pageNumber: movieListState.currentPage)
        }
    }
    
    @Sendable
    private func resetPages () {
        Task {
            await self.movieListState.fetchMoviesFromEndpoint(endpoint, pageNumber: movieListState.currentPage)
        }
    }}

struct MoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesGridView(title: "Upcoming", totalResults: 99, endpoint: .nowPlaying)
    }
}
