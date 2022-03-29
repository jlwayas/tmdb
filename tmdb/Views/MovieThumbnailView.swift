//
//  MoviePosterCard.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

enum MovieThumbnailType {
    case backdrop
    case gridItem
    case poster(showTitle: Bool = true)
}

struct MovieThumbnailView: View {
    
    let movie: Movie
    var thumbnailType: MovieThumbnailType = .poster()
    @StateObject var imageLoader = ImageLoader()
    
    private var cornerRadiusByThumbnailType: CGFloat {
        switch(thumbnailType) {
        case .backdrop, .poster:
            return CGFloat(8)
        default:
            return CGFloat(0)
        }
    }
    
    private var shadowRadiusByThumbnailType: CGFloat {
        switch(thumbnailType) {
        case .backdrop, .poster:
            return CGFloat(4)
        default:
            return CGFloat(0)
        }
    }
    
    var body: some View {
        containerView
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                switch thumbnailType {
                case .backdrop:
                    imageLoader.loadImage(with: movie.backdropURL)
                default:
                    imageLoader.loadImage(with: movie.posterURL)
                }
            }
        }
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .backdrop = thumbnailType {
            VStack(alignment: .leading, spacing: 8) {
                imageView
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)
            }
        } else {
            imageView
        }
    }
        
    private var imageView: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            if case .poster(let showTitle) = thumbnailType, showTitle {
                Text(movie.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(4)
            }
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
            }
        }
        .cornerRadius(cornerRadiusByThumbnailType)
        .shadow(radius: shadowRadiusByThumbnailType)
    }
    
    
    
}

struct MovieThumbnailView_Preview : PreviewProvider {
    static var previews: some View {
        Group {
            MovieThumbnailView(movie: Movie.stubbedMovie, thumbnailType: .poster(showTitle: true))
                .frame(width: 204, height: 306)
            MovieThumbnailView(movie: Movie.stubbedMovie, thumbnailType: .backdrop)
                .aspectRatio(16 / 9, contentMode: .fit)
                .frame(height: 160)
        }
    }
}
