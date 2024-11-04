//
//  BookmarkViewModel.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 02/11/24.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    
    @Published private(set) var bookmarks: [Article] = []
    var bookmarkStore = DataStore()
    
    
    static let shared = BookmarkViewModel()
    init() {
        load()
    }
    
    func load() {
        let loadedBookmarks = bookmarkStore.loadBookMark()
        
        DispatchQueue.main.async {
            self.bookmarks = loadedBookmarks
        }
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { article.title == $0.title } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.title == article.title }) else {
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        bookmarkStore.saveBookMarkList(bookmarks)
    }
}

