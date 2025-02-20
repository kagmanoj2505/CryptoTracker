//
//  FavoritesManager.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 20/2/25.
//

import Foundation

class FavoritesManager {
    private let favoritesKey = "favoriteCoins"
    
    func addFavorite(_ coin: CoinList) {
        var favorites = getFavorites()
        favorites.append(coin)
        saveFavorites(favorites)
    }
    
    func removeFavorite(_ coin: CoinList) {
        var favorites = getFavorites()
        favorites.removeAll { $0.uuid == coin.uuid }
        saveFavorites(favorites)
    }
    
    func getFavorites() -> [CoinList] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode([CoinList].self, from: data) {
            return favorites
        }
        return []
    }
    
    func isFavorite(_ coin: CoinList) -> Bool {
        return getFavorites().contains { $0.uuid == coin.uuid }
    }
    
    private func saveFavorites(_ favorites: [CoinList]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
