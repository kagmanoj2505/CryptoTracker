//
//  NetworkMonitor.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Network

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
}


final class NetworkMonitor: NetworkMonitorProtocol {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    private(set) var isConnected: Bool = false
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let `self` = self else { return }
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
