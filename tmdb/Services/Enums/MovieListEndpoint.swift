//
//  MovieListEndpoint.swift
//  tmdb
//
//  Created by Jesùs Wayas on 05/04/22.
//

import Foundation

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}
