//
//  MovieDetailView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    let movieTitle: String
    @StateObject private var movieDetailState = MovieDetailState()
    @State private var selectedTrailerURL: URL?
    
    var body: some View {
        List {
            if let movie = movieDetailState.movie {
                MovieDetailImage(imageURL: movie.backdropURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                
                MovieDetailListView(movie: movie, selectedTrailerURL: $selectedTrailerURL)
            }
        }
        .listStyle(.plain)
        .navigationTitle(movieTitle)
        .overlay(
            DataFetchPhaseOverlayView(phase: movieDetailState.phase, retryAction: loadMovie)
        )
        .refreshable { loadMovie() }
        .sheet(item: $selectedTrailerURL) { SafariView(url: $0).edgesIgnoringSafeArea(.bottom) }
        .task { loadMovie() }
    }
    
    @Sendable
    private func loadMovie () {
        Task {
            await self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

extension URL: Identifiable {
    public var id: Self { self }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id, movieTitle: Movie.stubbedMovie.title)
        }
    }
}
