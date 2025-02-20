//
//  CoinListViewControllerTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
@testable import EquityCoinRanking

class CoinListViewControllerTests: XCTestCase {
    var viewController: CoinListViewController!
    var mockFavoritesManager: MockFavoritesManager!
    
    override func setUp() {
        super.setUp()
        mockFavoritesManager = MockFavoritesManager()
        viewController = CoinListViewController()
    }
    
    func testFavoriteAction() {
        let coin = CoinList(
            uuid: "534345",
            name: "BTC",
            price: "1.23",
            symbol: "YTC",
            iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
            change: "1.43",
            marketCap: "34234232",
            volume24h: "32132",
            rank: 3,
            listedAt: 32211.21,
            sparkline: []
        )
        
        // Test adding to favorites
//        viewController.handleFavoriteAction(for: coin, isFavorite: false)
//        XCTAssertTrue(mockFavoritesManager.isFavorite(coin))
        
        // Test removing from favorites
//        viewController.handleFavoriteAction(for: coin, isFavorite: true)
//        XCTAssertFalse(mockFavoritesManager.isFavorite(coin))
    }
}
