//
//  Constants.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation

enum ErrorMessage: String {
    case noInternet = "Internet not Available."
    case invalidURL = "Invalid URL."
    case invalidResponse = "Invalid Response."
    case decodingFailed = "Decoding Fail"
}

enum APIUrl: String {
    case baseURL = "https://api.coinranking.com/v2"
    case coins = "/coins"
    case coin = "/coin/"
}

enum Parameters: String {
    case timePeriod = "timePeriod"
    case limit = "limit"
    case offset = "offset"
    case hours = "24h"
    case orderBy = "orderBy"
    case price = "price"
}

enum HTTPMethods: String {
    case get = "GET"
}

enum CommonMessage: String {
    case pullToRefresh = "Pull to refresh"
}

enum TimeFilter: String {
    case h1 = "1h"
    case h3 = "3h"
    case h12 = "12h"
    case h24 = "24h"
    case d7 = "7d"
    case d30 = "30D"
    case m3 = "3m"
    case y1 = "1y"
    case y3 = "3y"
    case y5 = "5y"
}


