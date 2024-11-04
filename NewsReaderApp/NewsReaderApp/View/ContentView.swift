//
//  ContentView.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
