//
//  Movie+Stub.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import Foundation

extension Movie {
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJson(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        return stubbedMovies[0]
    }
}

extension Bundle {
    func loadAndDecodeJson<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodeModel = try jsonDecoder.decode(D.self, from: data)
        return decodeModel
    }
}
