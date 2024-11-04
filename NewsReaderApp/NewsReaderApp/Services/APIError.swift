//
//  APIError.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 04/11/24.
//

import Foundation

// Define custom error for API handling
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
