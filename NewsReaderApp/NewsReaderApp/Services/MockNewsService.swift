//
//  MockNewsService.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 02/11/24.
//

import Combine
import Foundation

class MockNewsService: NewsServiceProtocol {
    var mockArticles: [Article]?
    var mockError: Error?

    func fetchNews(category: String) -> AnyPublisher<[Article], Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        guard let articles = mockArticles else {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return Just(articles)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
