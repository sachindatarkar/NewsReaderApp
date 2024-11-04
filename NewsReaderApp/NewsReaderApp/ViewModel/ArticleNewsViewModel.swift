//
//  ArticleNewsViewModel.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation
import Combine

class ArticleNewsViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var errorMessage: String? = nil
    @Published var selectedCategory: NewsCategory = .technology
    
    private let newsService: NewsServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }
    
    func loadNews(for category: NewsCategory? = nil) {
        let category = category ?? selectedCategory
        newsService.fetchNews(category: category.rawValue)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { articles in
                self.articles = articles
            })
            .store(in: &cancellables)
    }
}
