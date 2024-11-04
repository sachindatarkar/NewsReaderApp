//
//  DataStore.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 31/10/24.
//

import Foundation

protocol DataStoreProtocol {
    func loadBookMark() -> [Article]
    func saveBookMarkList(_ articles: [Article])
    func uniqueArticles(from lists: [[Article]]) -> [Article]
}

class DataStore: DataStoreProtocol {
    private let bookmarkKey = "bookMark"
    
    func loadBookMark() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: bookmarkKey) else {
            return []
        }
        do {
            let users = try JSONDecoder().decode([Article].self, from: data)
            return users
        } catch {
            print("Error decoding: \(error)")
            return []
        }
    }
    
    func saveBookMarkList(_ articles: [Article]) {
        do {
            let saveList = loadBookMark()
            let uniqueList = uniqueArticles(from: [articles, saveList])
            let data = try JSONEncoder().encode(uniqueList)
            UserDefaults.standard.set(data, forKey: bookmarkKey)
        } catch {
            print("Error encoding: \(error)")
        }
    }
    
    func uniqueArticles(from lists: [[Article]]) -> [Article] {
        var uniqueSet = Set<Article>()
        
        for list in lists {
            for article in list {
                uniqueSet.insert(article) // Set will handle duplicates automatically
            }
        }
        
        return Array(uniqueSet)
    }
}
