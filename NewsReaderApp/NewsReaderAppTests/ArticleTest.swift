//
//  ArticleTest.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
@testable import NewsReaderApp

final class ArticleTest: XCTestCase {

    func testArticleDecoding() throws {
        let json = """
            {
                "source": { "name": "Test Source" },
                "title": "Test Title",
                "url": "https://www.example.com",
                "publishedAt": "2023-10-25T12:34:56Z",
                "author": "Test Author",
                "description": "Test Description",
                "urlToImage": "https://www.example.com/image.jpg"
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let article = try decoder.decode(Article.self, from: json)
        
        XCTAssertEqual(article.source.name, "Test Source")
        XCTAssertEqual(article.title, "Test Title")
        XCTAssertEqual(article.url, "https://www.example.com")
        XCTAssertEqual(article.publishedAt, "2023-10-25T12:34:56Z")
        XCTAssertEqual(article.author, "Test Author")
        XCTAssertEqual(article.description, "Test Description")
        XCTAssertEqual(article.urlToImage, "https://www.example.com/image.jpg")
    }
    
    func testAuthorTextWhenAuthorIsPresent() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.authorText, "Test Author")
    }
    
    func testAuthorTextWhenAuthorIsNil() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: nil,
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.authorText, "")
    }
    
    func testDescriptionTextWhenDescriptionIsPresent() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.descriptionText, "Test Description")
    }
    
    func testDescriptionTextWhenDescriptionIsNil() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: nil,
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.descriptionText, "")
    }
    
    func testCaptionText() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        // Capturing the output to ensure date is formatted as expected
        let captionText = article.captionText
        XCTAssertTrue(captionText.contains("ago") || captionText.contains("minutes") || captionText.contains("hours"))
    }
    
    func testArticleURL() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.articleURL, URL(string: "https://www.example.com")!)
    }
    
    func testImageURLWhenURLToImageIsPresent() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: "https://www.example.com/image.jpg"
        )
        
        XCTAssertEqual(article.imageURL, URL(string: "https://www.example.com/image.jpg"))
    }
    
    func testImageURLWhenURLToImageIsNil() {
        let article = Article(
            source: Source(name: "Test Source"),
            title: "Test Title",
            url: "https://www.example.com",
            publishedAt: "2023-10-25T12:34:56Z",
            author: "Test Author",
            description: "Test Description",
            urlToImage: nil
        )
        
        XCTAssertNil(article.imageURL)
    }

}
