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
            NavigationView{ MovieHomeView() }
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
                .accessibilityIdentifier("Tab0Home")
            NavigationView { MovieSearchView() }
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
                .accessibilityIdentifier("tab1Search")
        }
        .accessibilityIdentifier("tabCOntainer")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
