//
//  MovieHomeView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct MovieHomeView: View {
    
    @StateObject private var movieHomeState = MovieHomeState()
    
    init() {
        if #available(iOS 14.0, *) {
            // iOS 14 doesn't have extra separators below the list by default.
        } else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        List {
            ForEach(movieHomeState.sections) {
                MovieThumbnailCarouselView(title: $0.title, movies: $0.movies, thumbnailType: $0.thumbnailType)
            }
            .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .task { loadMovies(invalidateCache: false) }
        .refreshable { loadMovies(invalidateCache: true) }
        .overlay(
            DataFetchPhaseOverlayView(phase: movieHomeState.phase, retryAction: { loadMovies(invalidateCache: true) })
        )
        
        .listStyle(.plain)
        .navigationTitle("TMDB")
    }
    
    @Sendable
    private func loadMovies(invalidateCache: Bool) {
        Task {
            await movieHomeState.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache)
        }
    }
}

struct MovieHomeView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieHomeView()            
        }
    }
}
