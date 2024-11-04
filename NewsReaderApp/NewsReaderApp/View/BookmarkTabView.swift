//
//  BookmarkTabView.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 02/11/24.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    
    private var articles: [Article] {
        return bookmarkViewModel.bookmarks
    }
    
    var body: some View {
        let articles = self.articles
        
        NavigationView {
            NewsArticleList(articles: articles)
            .overlay(overlayView(isEmpty: articles.isEmpty))
            .navigationTitle("Saved Articles")
        }
        
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
    
}

struct BookmarkTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkViewModel = BookmarkViewModel.shared
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(bookmarkViewModel)
    }
}
