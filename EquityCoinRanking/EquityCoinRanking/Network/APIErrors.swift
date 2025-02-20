//
//  APIErrors.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation

enum APIError: Error {
    case noInternet
    case invalidURL
    case invalidResponse
    case decodingFailed
    
    var errorMessage: String {
        switch self {
        case .noInternet:
            return ErrorMessage.noInternet.rawValue
        case .invalidURL:
            return ErrorMessage.invalidURL.rawValue
        case .invalidResponse:
            return ErrorMessage.invalidResponse.rawValue
        case .decodingFailed:
            return ErrorMessage.decodingFailed.rawValue
        }
    }
}
