//
//  APIManager.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation
import Combine


protocol NewsServiceProtocol {
    func fetchNews(category: String) -> AnyPublisher<[Article], Error>
}

class NewsService: NewsServiceProtocol {
    private let apiKey = "8c1a6e5f68894e818ff42f7f2f4187ac"
    
    func fetchNews(category: String) -> AnyPublisher<[Article], Error> {
        let urlString = generateNewsURL(from: category)
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map { $0.articles! }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func generateNewsURL(from category: String) -> String {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category)"
        return url
    }
}
