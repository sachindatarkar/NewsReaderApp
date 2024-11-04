//
//  NewsServiceTests.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
import Combine
@testable import NewsReaderApp


final class NewsServiceTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    var mockService: MockNewsService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
    }
    
    override func tearDown() {
        cancellables = []
        mockService = nil
        super.tearDown()
    }
    
    func testFetchNewsSuccess() {
        // Given
        let expectedArticle = Article.previewData.first
        mockService.mockArticles = Article.previewData
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news success")
        
        mockService.fetchNews(category: "general")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success but got failure")
                case .finished:
                    break
                }
            }, receiveValue: { articles in
                // Then
                XCTAssertEqual(articles.count, Article.previewData.count, "Should return 1 article.")
                XCTAssertEqual(articles.first?.title, expectedArticle?.title, "The returned article should match the expected article.")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchNewsFailure() {
        // Given
        mockService.mockError = URLError(.badServerResponse)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news failure")
        
        mockService.fetchNews(category: "general")
            .sink(receiveCompletion: { completion in
                // Then
                switch completion {
                case .failure(let error):
                    XCTAssertEqual((error as! URLError).code, URLError.Code.badServerResponse, "Expected bad server response error.")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value but received some.")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchNewsNoArticles() {
        // Given
        mockService.mockArticles = []
        
        // When
        let expectation = XCTestExpectation(description: "Fetch news no articles")
        
        mockService.fetchNews(category: "general")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success but got failure")
                case .finished:
                    break
                }
            }, receiveValue: { articles in
                // Then
                XCTAssertTrue(articles.isEmpty, "Should return an empty array when no articles are available.")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
