//
//  CoinsViewModel.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//
import Foundation
import Combine

class CoinListViewModel {
    @Published var coins: [CoinList] = []
    @Published var filteredCoins: [CoinList] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showFavoritesOnly = false
    
    private let networkManager: NetworkManagerProtocol
    private let favoritesManager: FavoritesManager
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 0
    private let limit = 20
    private var totalCoins: Int = 0 // Track total coins available on the server
    var selectedTimeFilter: TimeFilter = .h24
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(), favoritesManager: FavoritesManager) {
        self.networkManager = networkManager
        self.favoritesManager = favoritesManager
    }
    
    func canLoadMore() -> Bool {
        return coins.count < totalCoins
    }
    
    func fetchCoins(refresh: Bool = false, coinType: CoinFetchType = .all) {
        if refresh {
            currentPage = 0
        }
        
        isLoading = true
        
        let offset = currentPage * limit
        var endPoint: EndPoint = .coinList(limit: limit, offset: offset)
        switch coinType {
        case .all:
            endPoint = EndPoint.coinList(limit: limit, offset: offset)
        case .price:
            endPoint = EndPoint.coinListByPrice(limit: limit, offset: offset)
        case .period(let timeFilter):
            endPoint = EndPoint.coinListByPeriod(limit: limit, offset: offset, timePeriod: timeFilter.rawValue)
        }
        
        networkManager.fetchData(endPoint)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.errorMessage
                }
            } receiveValue: { [weak self] (response: CoinListResponse) in
                if refresh {
                    self?.coins = response.data.coins
                } else {
                    self?.coins.append(contentsOf: response.data.coins)
                }
                self?.filteredCoins = self?.coins ?? []
                self?.totalCoins = response.data.stats.total // Update total coins
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }
    
    func searchCoins(searchText: String) {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = coins.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    func updateFilteredCoins() {
        if showFavoritesOnly {
            filteredCoins = coins.filter { favoritesManager.isFavorite($0) }
        } else {
            filteredCoins = coins
        }
    }
    
    func toggleFavoriteFilter() {
        showFavoritesOnly.toggle()
        updateFilteredCoins()
    }
}
