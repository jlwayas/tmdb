//
//  MovieResponse.swift
//  tmdb
//
//  Created by Jesùs Wayas on 02/04/22.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
