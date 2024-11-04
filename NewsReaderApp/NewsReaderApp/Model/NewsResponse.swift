//
//  NewsResponse.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
