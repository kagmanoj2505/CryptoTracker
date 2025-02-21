//
//  CoinList.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//


struct CoinListResponse: Codable {
    let data: CoinData
}

struct CoinData: Codable {
    let stats: CoinStats
    let coins: [CoinList]
}

struct CoinStats: Codable {
    let total: Int
}

struct CoinList: Codable, Identifiable {
    var id: String {
        return uuid
    }
    
    var sparklineData: [Double] {
        return sparkline
            .compactMap { $0 != nil ? Double($0!) : nil }
    }

    var marketCapitalization: Double {
        return Double(marketCap) ?? 0.0
    }
    
    var hourlyVol: Double {
        return Double(volume24h) ?? 0.0
    }
    
    let uuid: String
    let name: String
    let price: String
    let symbol: String
    let iconUrl: String
    let change: String
    let marketCap: String
    let volume24h: String
    let description: String?
    let rank: Int
    let listedAt: Double?
    let sparkline: [String?]
    
    enum CodingKeys: String, CodingKey {
            case uuid
            case name
            case price
            case symbol
            case iconUrl
            case change
            case rank
            case description
            case listedAt
            case sparkline
            case marketCap
            case volume24h = "24hVolume" // Map JSON key to valid Swift property
        }
}

struct CoinDetailResponse: Codable {
    let data: CoinDetail
}

struct CoinDetail: Codable {
    let coin: CoinList
}

extension CoinList {
    static let placeholder = CoinList(
        uuid: "placeholder",
        name: "Bitcoin",
        price: "0.00",
        symbol: "BTC",
        iconUrl: "",
        change: "0",
        marketCap: "0",
        volume24h: "0",
        description: "description here",
        rank: 1,
        listedAt: 0,
        sparkline: []
    )
}
