//
//  MovieSearchView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 26/03/22.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject var movieSearchState = MovieSearchState()
    
    var body: some View {
        List {
            ForEach(movieSearchState.movies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                    MovieRowView(movie: movie)
                        .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Search")
        .onAppear { movieSearchState.startObserve() }
        .overlay(
            overlayView
        )
        .searchable(text: $movieSearchState.query, prompt: "Search movie")
        .disableAutocorrection(true)
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch movieSearchState.phase {
        case .empty:
            if movieSearchState.trimmedQuery.isEmpty {
                EmptyPlaceholderView(text: "Search your favourite movie", image: Image(systemName: "magnifyingglass"))
            } else {
                ProgressView()
            }
        case .success(let values) where values.isEmpty:
            EmptyPlaceholderView(text: "No results", image: Image(systemName: "film"))
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                Task {
                    await movieSearchState.search(query: movieSearchState.query)
                }
            }
        default:
            EmptyView()
        }
    }
    
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
