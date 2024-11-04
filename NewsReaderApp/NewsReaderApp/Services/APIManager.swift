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
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func fetchNews(category: String) -> AnyPublisher<[Article], Error> {
        let urlString = generateNewsURL(from: category)
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    throw APIError.invalidResponse
                }
                return output.data
            }
            .decode(type: NewsResponse.self, decoder: decoder)
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.decodingError(error)
                }
            }
            .map { response in
                response.articles ?? []
            }
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
