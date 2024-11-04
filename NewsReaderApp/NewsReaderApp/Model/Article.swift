//
//  Article.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation
fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article: Codable, Equatable, Identifiable, Hashable  {
    
    let id = UUID()
    let source: Source
    let title: String
    let url: String
    let publishedAt: String
    let author: String?
    let description: String?
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case publishedAt
        case author
        case description
        case urlToImage
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withTimeZone]
        
        guard let date = isoFormatter.date(from: publishedAt) else { return "Invalid date" }
        
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        return relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "dummyNews", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}


struct Source: Codable, Equatable, Hashable {
    let name: String
}

