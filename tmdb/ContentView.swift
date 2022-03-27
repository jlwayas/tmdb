//
//  ContentView.swift
//  tmdb
//
//  Created by Jesùs Antonio Lòpez Wayas on 25/03/22.
//

import SwiftUI

struct ContentView: View {
    
//    init() {
//        UITabBar.appearance().isTranslucent = true
////        UITabBar.appearance().barTintColor = UIColor.black
//        UITableView.appearance().separatorStyle = .none
//    }
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
            MovieSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
        }
//        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
