//
//  ArticleNewsViewModelTests.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
import Combine
@testable import NewsReaderApp

final class ArticleNewsViewModelTests: XCTestCase {
    
    var viewModel: ArticleNewsViewModel!
    var mockService: MockNewsService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        viewModel = ArticleNewsViewModel(newsService: mockService)
    }
    
    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadNewsSuccess() {
        // Given
        let expectedArticle = Article.previewData.first
        mockService.mockArticles = Article.previewData
        
        // When
        let expectation = XCTestExpectation(description: "Load news success")
        
        viewModel.$articles
            .dropFirst() // Skip initial empty state
            .sink { articles in
                // Then
                XCTAssertEqual(articles.count, Article.previewData.count, "Should return article count.")
                XCTAssertEqual(articles.first?.title, expectedArticle?.title, "The returned article should match the expected article.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadNews()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadNewsFailure() {
        // Given
        mockService.mockError = URLError(.badServerResponse)
        
        // When
        let expectation = XCTestExpectation(description: "Load news failure")
        
        viewModel.$errorMessage
            .dropFirst() // Skip initial nil state
            .sink { errorMessage in
                // Then
                XCTAssertEqual(errorMessage, URLError(.badServerResponse).localizedDescription, "Error message should match the expected error.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadNews()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadNewsSelectedCategory() {
        // Given
        let expectedArticle = Article.previewData.first
        mockService.mockArticles = Article.previewData
        
        // When
        let expectation = XCTestExpectation(description: "Load news for selected category")
        
        viewModel.$articles
            .dropFirst() // Skip initial empty state
            .sink { articles in
                // Then
                XCTAssertEqual(articles.count, Article.previewData.count, "Should return article count.")
                XCTAssertEqual(articles.first?.title, expectedArticle?.title, "The returned article should match the expected article.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadNews() // Loads using the default selected category
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
