//
//  MoviePosterCarouselView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct MovieThumbnailCarouselView: View {
    
    let title: String
    let totalPages: Int
    let totalResults: Int
    let movies: [Movie]
    var thumbnailType: MovieThumbnailType = .poster()
    let endpoint: MovieListEndpoint
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if MovieListEndpoint.nowPlaying != endpoint {
                HStack {
                    NavigationLink(
                        destination: MoviesByCategoryView(title: title, totalPages: totalPages, totalResults: totalResults, endpoint: endpoint)) {
                            Text(title)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.bold)
                                .padding(.leading)
                        }
                    .buttonStyle(.plain)
                    .padding(.trailing)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                            MovieThumbnailView(movie: movie, thumbnailType: thumbnailType)
                                .movieThumbnailViewFrame(thumbnailType: thumbnailType)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
    }
}

fileprivate extension View {
    
    @ViewBuilder
    func movieThumbnailViewFrame(thumbnailType: MovieThumbnailType) -> some View {
        switch thumbnailType {
        case .poster, .gridItem:
            self.frame(width: 204, height: 306)
        case .backdrop:
            self
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
        }
    }
    
}

struct MovieThumbnailCarouselView_Preview: PreviewProvider {
    
    static let stubbedMovies = Movie.stubbedMovies
    
    static var previews: some View {
        Group {
            MovieThumbnailCarouselView(title: "Now Playing", totalPages: 7, totalResults: 99, movies: stubbedMovies, thumbnailType: .poster(showTitle: true), endpoint: .nowPlaying)
            MovieThumbnailCarouselView(title: "Upcoming", totalPages: 7, totalResults: 99, movies: stubbedMovies, thumbnailType: .backdrop, endpoint: .nowPlaying)
        }
    }
}
