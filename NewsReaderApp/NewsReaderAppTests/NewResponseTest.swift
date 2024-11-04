//
//  NewResponseTest.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
@testable import NewsReaderApp

final class NewResponseTest: XCTestCase {

    func testNewsResponseDecodingWithValidJSON() throws {
        let json = """
            {
                "status": "ok",
                "totalResults": 10,
                "articles": [
                    {
                        "source": { "name": "Test Source" },
                        "title": "Test Title",
                        "url": "https://www.example.com",
                        "publishedAt": "2023-10-25T12:34:56Z",
                        "author": "Test Author",
                        "description": "Test Description",
                        "urlToImage": "https://www.example.com/image.jpg"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(NewsResponse.self, from: json)
        
        XCTAssertEqual(response.status, "ok")
        XCTAssertEqual(response.totalResults, 10)
        XCTAssertEqual(response.articles?.count, 1)
        
        let article = response.articles?.first
        XCTAssertEqual(article?.source.name, "Test Source")
        XCTAssertEqual(article?.title, "Test Title")
        XCTAssertEqual(article?.url, "https://www.example.com")
        XCTAssertEqual(article?.publishedAt, "2023-10-25T12:34:56Z")
        XCTAssertEqual(article?.author, "Test Author")
        XCTAssertEqual(article?.description, "Test Description")
        XCTAssertEqual(article?.urlToImage, "https://www.example.com/image.jpg")
    }
    
    func testNewsResponseDecodingWithMissingFields() throws {
        let json = """
            {
                "status": "ok"
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(NewsResponse.self, from: json)
        
        XCTAssertEqual(response.status, "ok")
        XCTAssertNil(response.totalResults)
        XCTAssertNil(response.articles)
    }
    
    func testNewsResponseDecodingWithEmptyArticles() throws {
        let json = """
            {
                "status": "ok",
                "totalResults": 0,
                "articles": []
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(NewsResponse.self, from: json)
        
        XCTAssertEqual(response.status, "ok")
        XCTAssertEqual(response.totalResults, 0)
        XCTAssertEqual(response.articles?.count, 0)
    }
    
    func testNewsResponseDecodingWithNilStatus() throws {
        let json = """
            {
                "totalResults": 5,
                "articles": [
                    {
                        "source": { "name": "Another Source" },
                        "title": "Another Title",
                        "url": "https://www.example2.com",
                        "publishedAt": "2023-10-26T12:00:00Z",
                        "author": "Another Author",
                        "description": "Another Description",
                        "urlToImage": "https://www.example2.com/image.jpg"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(NewsResponse.self, from: json)
        
        XCTAssertNil(response.status)
        XCTAssertEqual(response.totalResults, 5)
        XCTAssertEqual(response.articles?.count, 1)
        
        let article = response.articles?.first
        XCTAssertEqual(article?.source.name, "Another Source")
        XCTAssertEqual(article?.title, "Another Title")
        XCTAssertEqual(article?.url, "https://www.example2.com")
        XCTAssertEqual(article?.publishedAt, "2023-10-26T12:00:00Z")
        XCTAssertEqual(article?.author, "Another Author")
        XCTAssertEqual(article?.description, "Another Description")
        XCTAssertEqual(article?.urlToImage, "https://www.example2.com/image.jpg")
    }

}
