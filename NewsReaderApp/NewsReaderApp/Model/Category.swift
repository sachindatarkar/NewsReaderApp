//
//  Category.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case technology, sports, business, entertainment, health, science
    
    var id: String { self.rawValue }
    var displayName: String {
        switch self {
        case .technology: return "Technology"
        case .sports: return "Sports"
        case .business: return "Business"
        case .entertainment: return "Entertainment"
        case .health: return "Health"
        case .science: return "Science"
        }
    }
}
