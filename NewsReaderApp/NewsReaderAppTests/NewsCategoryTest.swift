//
//  NewsCategoryTest.swift
//  NewsReaderAppTests
//
//  Created by Sachin Datarkar on 02/11/24.
//

import XCTest
@testable import NewsReaderApp

final class NewsCategoryTest: XCTestCase {

    func testAllCasesCount() {
        XCTAssertEqual(NewsCategory.allCases.count, 6)
    }
    
    func testIdsMatchRawValues() {
        NewsCategory.allCases.forEach { category in
            XCTAssertEqual(category.id, category.rawValue)
        }
    }
    
    func testDisplayName() {
        XCTAssertEqual(NewsCategory.technology.displayName, "Technology")
        XCTAssertEqual(NewsCategory.sports.displayName, "Sports")
        XCTAssertEqual(NewsCategory.business.displayName, "Business")
        XCTAssertEqual(NewsCategory.entertainment.displayName, "Entertainment")
        XCTAssertEqual(NewsCategory.health.displayName, "Health")
        XCTAssertEqual(NewsCategory.science.displayName, "Science")
    }
    
    func testCaseIterableConformance() {
        let expectedCategories: [NewsCategory] = [
            .technology, .sports, .business, .entertainment, .health, .science
        ]
        XCTAssertEqual(NewsCategory.allCases, expectedCategories)
    }
}
