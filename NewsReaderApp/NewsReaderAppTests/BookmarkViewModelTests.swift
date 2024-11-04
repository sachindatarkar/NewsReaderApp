//
//  BookmarkViewModelTests.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
@testable import NewsReaderApp

final class BookmarkViewModelTests: XCTestCase {
    
    var viewModel: BookmarkViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = BookmarkViewModel()
        viewModel.bookmarkStore = DataStore()
    }
    
    override func tearDown() {
        // Clear bookmarks for each test if needed
        // mockDataStore.clearBookmarks()
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadBookmarks() throws {
        // Setup mock data
        let article1 = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        let article2 = Article(
            source: Source(name: "Test Source2"),
            title: "Article 2",
            url: "https://www.example.com2",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description2",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        viewModel.addBookmark(for: article1)
        viewModel.addBookmark(for: article2)
        
        // Load bookmarks
        viewModel.load()
        
        // Assert that bookmarks are loaded correctly
        XCTAssertEqual(viewModel.bookmarks.count, 2, "Should load 2 bookmarks.")
        XCTAssertEqual(viewModel.bookmarks[0].title, "Article 2", "First bookmark should be Article 2.")
        XCTAssertEqual(viewModel.bookmarks[1].title, "Article 1", "Second bookmark should be Article 1.")
    }
    
    func testAddBookmark() {
        let article1 = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        // Add bookmark
        viewModel.addBookmark(for: article1)
        
        // Assert that the bookmark was added
        XCTAssertEqual(viewModel.bookmarks.count, 1, "Should have 1 bookmark.")
        XCTAssertEqual(viewModel.bookmarks[0].title, "Article 1", "The added bookmark should match the article.")
        
        // Check that it is marked as bookmarked
        XCTAssertTrue(viewModel.isBookmarked(for: article1), "The article should be marked as bookmarked.")
    }
    
    func testAddDuplicateBookmark() {
        let article1 = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        // Add bookmark
        viewModel.addBookmark(for: article1)
        // Try adding the same bookmark again
        viewModel.addBookmark(for: article1)
        
        // Assert that the bookmark is still only counted once
        XCTAssertEqual(viewModel.bookmarks.count, 1, "Should still have only 1 bookmark.")
    }
    
    func testRemoveBookmark() {
        let article = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        // Add bookmark
        viewModel.addBookmark(for: article)
        
        // Remove bookmark
        viewModel.removeBookmark(for: article)
        
        // Assert that the bookmark was removed
        XCTAssertEqual(viewModel.bookmarks.count, 0, "Should have 0 bookmarks after removal.")
    }
    
    func testIsBookmarked() {
        let article = Article(
            source: Source(name: "Test Source1"),
            title: "Article 1",
            url: "https://www.example.com1",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author1",
            description: "Test Description1",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        // Add bookmark
        viewModel.addBookmark(for: article)
        
        // Check if the article is bookmarked
        XCTAssertTrue(viewModel.isBookmarked(for: article), "The article should be marked as bookmarked.")
        
        // Remove the bookmark
        viewModel.removeBookmark(for: article)
        
        // Check again
        XCTAssertFalse(viewModel.isBookmarked(for: article), "The article should not be marked as bookmarked after removal.")
    }
    
}

