//
//  MovieCast.swift
//  tmdb
//
//  Created by Jesùs Wayas on 02/04/22.
//

import Foundation

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}
