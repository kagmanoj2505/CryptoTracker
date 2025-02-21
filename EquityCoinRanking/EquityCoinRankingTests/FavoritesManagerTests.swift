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
        favoritesManager.addFavorite(CoinList.placeholder)

        let favorites = favoritesManager.getFavorites()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.uuid, "placeholder")
    }

    func testRemoveFavorite() {
        favoritesManager.addFavorite(CoinList.placeholder)
        favoritesManager.removeFavorite(CoinList.placeholder)

        let favorites = favoritesManager.getFavorites()
        XCTAssertTrue(favorites.isEmpty)
    }

    func testIsFavorite() {
        favoritesManager.addFavorite(CoinList.placeholder)

        XCTAssertTrue(favoritesManager.isFavorite(CoinList.placeholder))
        favoritesManager.removeFavorite(CoinList.placeholder)
        XCTAssertFalse(favoritesManager.isFavorite(CoinList.placeholder))
    }
}
