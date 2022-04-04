//
//  MovieVideo.swift
//  tmdb
//
//  Created by Jesùs Wayas on 02/04/22.
//

import Foundation

struct MovieVideo: Decodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
