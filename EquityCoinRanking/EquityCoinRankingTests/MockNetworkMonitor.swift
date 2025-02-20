//
//  MockNetworkMonitor.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation
@testable import EquityCoinRanking

class MockNetworkMonitor: NetworkMonitorProtocol {
    var isConnected: Bool = true
}

class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didReceive: MockURLProtocol.response!, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.testData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
