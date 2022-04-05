//
//  MovieCredit.swift
//  tmdb
//
//  Created by Jesùs Wayas on 02/04/22.
//

import Foundation

struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}
