//
//  CoinListViewModelTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
import Combine
@testable import EquityCoinRanking

final class CoinListViewModelTests: XCTestCase {
    var viewModel: CoinListViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockFavoritesManager: MockFavoritesManager!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockFavoritesManager = MockFavoritesManager()
        viewModel = CoinListViewModel(networkManager: mockNetworkManager, favoritesManager: mockFavoritesManager)
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertTrue(viewModel.filteredCoins.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showFavoritesOnly)
    }

    func testCanLoadMore() {
//        viewModel.totalCoins = 50
        viewModel.coins = Array(repeating: CoinList.placeholder, count: 50)
        XCTAssertFalse(viewModel.canLoadMore())

        viewModel.coins = Array(repeating: CoinList.placeholder, count: 50)
        XCTAssertFalse(viewModel.canLoadMore())
    }

    func testFetchCoins_Success() {
        
        
        
        let mockResponse = CoinListResponse(data: CoinData(stats: CoinStats(total: 100), coins: [CoinList.placeholder]))
        mockNetworkManager.result = .success(mockResponse)

        viewModel.fetchCoins(refresh: true)

        XCTAssertTrue(viewModel.isLoading)

        let expectation = XCTestExpectation(description: "Fetch coin list")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.coins.count, 1)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testFetchCoins_Failure() {
        mockNetworkManager.result = .failure(.invalidResponse)

        viewModel.fetchCoins(refresh: true)

        let expectation = XCTestExpectation(description: "Fetch coin list failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.errorMessage, "Invalid Response.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testSearchCoins() {
        let mockCoin = CoinList(
            uuid: "534345",
            name: "BTC",
            price: "6000",
            symbol: "YTC",
            iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
            change: "1.43",
            marketCap: "34234232",
            volume24h: "32132",
            rank: 3,
            listedAt: 32211.21,
            sparkline: []
        )
        
        viewModel.coins = [mockCoin]

        viewModel.searchCoins(searchText: "bitcoin")
        XCTAssertEqual(viewModel.filteredCoins.count, 0)

        viewModel.searchCoins(searchText: "")
        XCTAssertEqual(viewModel.filteredCoins.count, 1)

        viewModel.searchCoins(searchText: "xrp")
        XCTAssertEqual(viewModel.filteredCoins.count, 0)
    }
}
