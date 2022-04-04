//
//  MovieCrew.swift
//  tmdb
//
//  Created by Jesùs Wayas on 02/04/22.
//

import Foundation

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}
