//
//  EndPoint.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import Foundation

enum EndPoint {
    case coinList(limit: Int, offset: Int)
    case coinListByPrice(limit: Int, offset: Int)
    case coinListByPeriod(limit: Int, offset: Int, timePeriod: String)
    case coinDetail(uuid: String)
    
    private var baseURL: String { return APIUrl.baseURL.rawValue }
    
    private var path: String {
        switch self {
        case .coinList, .coinListByPeriod, .coinListByPrice:
            return APIUrl.coins.rawValue
        case .coinDetail(let uuid):
            return "\(APIUrl.coin.rawValue)\(uuid)"
        }
    }
    
    private var parameters: [String: String] {
        switch self {
        case .coinList(let limit, let offset):
            return [Parameters.timePeriod.rawValue: Parameters.hours.rawValue, Parameters.limit.rawValue: "\(limit)", Parameters.offset.rawValue: "\(offset)"]
        case .coinListByPrice(let limit, let offset):
            return [Parameters.timePeriod.rawValue: Parameters.hours.rawValue, Parameters.limit.rawValue: "\(limit)", Parameters.offset.rawValue: "\(offset)", Parameters.orderBy.rawValue: Parameters.price.rawValue]
        case .coinListByPeriod(let limit, let offset, let timePeriod):
            return [Parameters.timePeriod.rawValue: "\(timePeriod)", Parameters.limit.rawValue: "\(limit)", Parameters.offset.rawValue: "\(offset)"]
        case .coinDetail:
            return [Parameters.timePeriod.rawValue: Parameters.hours.rawValue]
        }
    }
    
    var request: URLRequest? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("coinranking271d53aac35ef1f1d6336f946b173aa85962b66456ef3f64", forHTTPHeaderField: "x-access-token")
        return request
    }
}

enum CoinFetchType {
    case all
    case price
    case period(TimeFilter)
}

