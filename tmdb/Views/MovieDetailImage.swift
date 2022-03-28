//
//  MovieDetailImage.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct MovieDetailImage: View {
    
    @StateObject private var imageLoader: ImageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Text("Without image")
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear { self.imageLoader.loadImage(with: imageURL) }
    }
}

struct MovieDetailImage_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailImage(imageURL: Movie.stubbedMovie.backdropURL)
    }
}
