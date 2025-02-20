//
//  MockNetworkManager.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import Foundation
@testable import EquityCoinRanking
import Combine


class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<Any, APIError>?

    func fetchData<T>(_ endPoint: EndPoint) -> AnyPublisher<T, APIError> where T: Decodable {
        return Future<T, APIError> { promise in
            guard let result = self.result else {
                promise(.failure(.invalidResponse))
                return
            }

            switch result {
            case .success(let data):
                if let typedData = data as? T {
                    promise(.success(typedData))
                } else {
                    promise(.failure(.decodingFailed))
                }
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}


