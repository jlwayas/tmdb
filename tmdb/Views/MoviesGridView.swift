//
//  MoviesGridView.swift
//  tmdb
//
//  Created by user213150 on 3/28/22.
//

import SwiftUI

struct MoviesGridView: View {
    
    let title: String
    let endpoint: MovieListEndpoint
    @State private var pageNumber: Int = 1
    @StateObject private var movieListState = MovieListState()
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        List {
            ScrollView(.vertical, showsIndicators: false) {
                if let movieResponse = movieListState.movieResponse {
                    LazyVGrid(columns: columns) {
                        Section(header: headerView(totalResults: movieResponse.totalResults)) {
                            ForEach(movieResponse.results) { movie in
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
        .navigationBarTitle(title, displayMode: .inline)
        .overlay(
            DataFetchPhaseOverlayView(phase: movieListState.phase, retryAction: loadMovies)
        )
        .refreshable { loadMovies() }
        .task { loadMovies() }
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
    private func loadMovies () {
        Task {
            await self.movieListState.fetchMoviesFromEndpoint(endpoint, pageNumber: pageNumber)
        }
    }
}

struct MoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesGridView(title: "Upcoming", endpoint: .nowPlaying)
    }
}
