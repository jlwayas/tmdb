//
//  extension + movie.swift
//  tmdb
//
//  Created by Jesùs Wayas on 05/04/22.
//

import Foundation
extension Movie {
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        let response: Movie? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_info")
        return response!
    }
    
    static var stubbedMovieWithError: Movie {
        let response: Movie? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_info_with_errors")
        return response!
    }
}
