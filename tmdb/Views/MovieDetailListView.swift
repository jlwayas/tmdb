//
//  MovieDetailListView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct MovieDetailListView: View {
    
    let movie: Movie
    @Binding var selectedTrailerURL: URL?
    
    var body: some View {
        movieDescriptionSection
            .listRowSeparator(.visible)
        movieCastSection
            .listRowSeparator(.hidden)
        movieTrailerSection
    }
    
    private var movieCastSection: some View {
        HStack(alignment: .top, spacing: 4) {
            if let cast = movie.cast, !cast.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Starring").font(.headline)
                    ForEach(cast.prefix(9)) { Text($0.name) }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
                
            if let crew = movie.crew, !crew.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if let directors = movie.directors, !directors.isEmpty {
                        Text("Director(s)").font(.headline)
                        ForEach(directors.prefix(2)) { Text($0.name) }
                    }
                        
                    if let producers = movie.producers, !producers.isEmpty {
                        Text("Producer(s)").font(.headline)
                            .padding(.top)
                        ForEach(producers.prefix(2)) { Text($0.name) }
                    }
                        
                    if let screenWriters = movie.screenWriters, !screenWriters.isEmpty {
                        Text("Screenwriter(s)").font(.headline)
                            .padding(.top)
                        ForEach(screenWriters.prefix(2)) { Text($0.name) }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical)
    }
    
    private var movieDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(movieGenreYearDurationText)
                    .font(.headline)
            Text(movie.overview)
            HStack(spacing: 0) {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                    Text(movie.negativeRatingText).foregroundColor(.gray)
                }
                Text(movie.scoreText)
                    .padding(.leading, 16)
                Spacer()
            }
        }
        .padding(.vertical)
    }
    
    private var movieGenreYearDurationText: String {
        "\(movie.genreText) · \(movie.yearText) · \(movie.durationText)"
    }
    
    @ViewBuilder
    private var movieTrailerSection: some View {
        if let youtubeTrailers = movie.youtubeTrailers, !youtubeTrailers.isEmpty {
            Text("Trailers").font(.headline)
            ForEach(youtubeTrailers) { trailer in
                Button(action: {
                    guard let url = trailer.youtubeURL else { return }
                    selectedTrailerURL = url
                }) {
                    HStack {
                        Text(trailer.name)
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                }
            }
        }
    }
}

struct MovieDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailListView(movie: Movie.stubbedMovie, selectedTrailerURL: .constant(URL(string: "https://www.youtube.com")!))
    }
}
