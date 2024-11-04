//
//  NewsReaderAppApp.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import SwiftUI

@main
struct NewsReaderAppApp: App {
    
    @StateObject var bookmarkViewModel = BookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkViewModel)
        }
    }
}
