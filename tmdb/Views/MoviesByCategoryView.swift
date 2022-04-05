//
//  MoviesGridView.swift
//  tmdb
//
//  Created by user213150 on 3/28/22.
//

import SwiftUI

struct MoviesByCategoryView: View {
    
    let title: String
    let endpoint: MovieListEndpoint
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @StateObject private var movieListState = MovieListState()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
//        List {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    Section(header: headerView(label: movieListState.getCounterMovies(from: movieListState.movies.count))) {
                        ForEach(movieListState.query == "" ? movieListState.movies : movieListState.moviesFiltered) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                                if movie == movieListState.movies.last {
                                    if movieListState.isFetchingNextPage {
                                        bottomProgressView
                                    } else {
                                        MovieThumbnailView(movie: movie, thumbnailType: .gridItem)
                                            .onAppear(perform: {
                                                Task{
                                                    await movieListState.loadNextPageMovies(from: endpoint)
                                                }
                                            })
                                    }
                                } else {
                                    MovieThumbnailView(movie: movie, thumbnailType: .gridItem)
                                }
                            }
                            .buttonStyle(.plain)
                            .frame(height: 224)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
        .listStyle(.plain)
        .onAppear{ movieListState.startObserve() }
        .navigationBarTitle(title, displayMode: .inline)
        .overlay(
            overlayView
        )
        .refreshable { resetPages() }
        .searchable(text: $movieListState.query, prompt: "Search movie")
        .task { loadFirstPageMovies() }
    }
    
    private func getHeightForGridItem() -> CGFloat {
        switch verticalSizeClass {
        case .compact:
            return 224
        default:
            return 400
        }
    }
    
    
    private func headerView (label: String) -> some View {
        return HStack {
            Text(label)
                .font(.system(.headline, design: .rounded))
                .padding()
            Spacer()
        }
    }
    
    @ViewBuilder
    private var bottomProgressView: some View {
        Divider()
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }.padding()
    }
    
    @ViewBuilder
    private var overlayView: some View {
        if movieListState.query == "" {
            DataFetchPhaseOverlayView(phase: movieListState.phase, retryAction: loadFirstPageMovies)
        } else if movieListState.moviesFiltered.count == 0 {
            EmptyPlaceholderView(text: "No results", image: Image(systemName: "film"))
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
        MoviesByCategoryView(title: "Upcoming", endpoint: .nowPlaying)
    }
}
