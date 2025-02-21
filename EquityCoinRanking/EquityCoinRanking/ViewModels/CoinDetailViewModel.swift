//
//  CoinDetailViewModel.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 20/2/25.
//

import Foundation
import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    @Published var coinDetail: CoinList = CoinList.placeholder
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchCoinDetail(uuid: String) {
        isLoading = true
        networkManager.fetchData(EndPoint.coinDetail(uuid: uuid))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.errorMessage
                }
            } receiveValue: { [weak self] (response: CoinDetailResponse) in
                self?.coinDetail = response.data.coin
            }
            .store(in: &cancellables)
    }
}
