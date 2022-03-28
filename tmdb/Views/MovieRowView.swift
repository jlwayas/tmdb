//
//  MovieRowView.swift
//  tmdb
//
//  Created by user213150 on 3/28/22.
//

import SwiftUI

struct MovieRowView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MovieThumbnailView(movie: movie, thumbnailType: .poster(showTitle: false))
                .frame(width: 61, height: 92)
            VStack {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.yearText)
                        .font(.subheadline)
                Spacer()
                HStack(spacing: 0) {
                    Text(movie.ratingText).foregroundColor(.yellow)
                    Text(movie.negativeRatingText).foregroundColor(.gray)
                }
            }
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(movie: Movie.stubbedMovie)
    }
}
