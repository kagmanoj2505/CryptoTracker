//
//  FavoritesManagerTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
@testable import EquityCoinRanking

final class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!

    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager()
        UserDefaults.standard.removeObject(forKey: "favoriteCoins") // Clear data before each test
    }

    func testAddFavorite() {
        let mockCoin = CoinList(
            uuid: "1",
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
        favoritesManager.addFavorite(mockCoin)

        let favorites = favoritesManager.getFavorites()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.uuid, "1")
    }

    func testRemoveFavorite() {
        let mockCoin = CoinList(
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
        favoritesManager.addFavorite(mockCoin)
        favoritesManager.removeFavorite(mockCoin)

        let favorites = favoritesManager.getFavorites()
        XCTAssertTrue(favorites.isEmpty)
    }

    func testIsFavorite() {
        let mockCoin = CoinList(
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
        favoritesManager.addFavorite(mockCoin)

        XCTAssertTrue(favoritesManager.isFavorite(mockCoin))
        favoritesManager.removeFavorite(mockCoin)
        XCTAssertFalse(favoritesManager.isFavorite(mockCoin))
    }
}
