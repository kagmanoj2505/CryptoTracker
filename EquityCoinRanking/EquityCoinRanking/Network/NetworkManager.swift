//
//  NetworkManager.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(_ endPoint: EndPoint) -> AnyPublisher<T, APIError>
}

class NetworkManager: NetworkManagerProtocol {
    private let networkMonitor: NetworkMonitorProtocol
    
    init(networkMonitor: NetworkMonitorProtocol = NetworkMonitor()) {
        self.networkMonitor = networkMonitor
    }
    
    func fetchData<T: Decodable>(_ endPoint: EndPoint) -> AnyPublisher<T, APIError> {
        guard let request = endPoint.request else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error -> APIError in
                return APIError.invalidResponse
            }
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.decodingFailed
                }
            }
            .eraseToAnyPublisher()
    }
}
