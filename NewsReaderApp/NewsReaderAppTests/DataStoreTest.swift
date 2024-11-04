//
//  DataStoreTest.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
@testable import NewsReaderApp

final class DataStoreTest: XCTestCase {
    
    var dataStore: DataStore!
    
    override func setUp() {
        super.setUp()
        dataStore = DataStore()
        // Clear UserDefaults before each test
        UserDefaults.standard.removeObject(forKey: "bookMark")
    }
    
    override func tearDown() {
        // Clear UserDefaults after each test if needed
        UserDefaults.standard.removeObject(forKey: "bookMark")
        dataStore = nil
        super.tearDown()
    }
    
    func testSaveNewArticle() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        dataStore.saveBookMarkList([article])
        
        let savedArticles = dataStore.loadBookMark()
        XCTAssertEqual(savedArticles.count, 1, "Should have saved one article.")
        XCTAssertEqual(savedArticles.first?.title, article.title, "The saved article should match the original.")
    }
    
    func testSaveDuplicateArticle() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        dataStore.saveBookMarkList([article, article])
        
        let savedArticles = dataStore.loadBookMark()
        XCTAssertEqual(savedArticles.count, 1, "Should not save duplicate articles.")
    }
    
    func testSaveMultipleUniqueArticles() {
        let article1 = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z1",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg1"
        )
        
        let article2 = Article(
            source: Source(name: "Test Source2"),
            title: "Article 2",
            url: "https://www.example.com2",
            publishedAt: "2023-10-25T12:34:56Z2",
            author: "Test Author2",
            description: "Test Description2",
            urlToImage: "https://www.example.com/image.jpg2"
        )
        
        dataStore.saveBookMarkList([article1, article2])
        
        let savedArticles = dataStore.loadBookMark()
        XCTAssertEqual(savedArticles.count, 2, "Should have saved two unique articles.")
    }
    
    func testLoadNoArticles() {
        let savedArticles = dataStore.loadBookMark()
        XCTAssertTrue(savedArticles.isEmpty, "Should return an empty array when no articles are saved.")
    }
    
}
