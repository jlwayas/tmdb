//
//  DataFetchPhase.swift
//  tmdb
//
//  Created by user213150 on 3/27/22.
//

import Foundation

enum DataFetchPhase<V> {
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
