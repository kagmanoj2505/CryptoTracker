//
//  MockFavoritesManager.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import Foundation
@testable import EquityCoinRanking
class MockFavoritesManager: FavoritesManager {
    var favorites: [CoinList] = []
    
    override func addFavorite(_ coin: CoinList) {
        favorites.append(coin)
    }
    
    override func removeFavorite(_ coin: CoinList) {
        favorites.removeAll { $0.uuid == coin.uuid }
    }
    
    override func getFavorites() -> [CoinList] {
        return favorites
    }
    
    override func isFavorite(_ coin: CoinList) -> Bool {
        return favorites.contains { $0.uuid == coin.uuid }
    }
}
