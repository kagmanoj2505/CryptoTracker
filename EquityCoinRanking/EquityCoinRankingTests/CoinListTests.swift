//
//  CoinListTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
@testable import EquityCoinRanking

final class CoinListTests: XCTestCase {

    var sampleCoin: CoinList!

    override func setUp() {
        super.setUp()
        sampleCoin = CoinList(
            uuid: "Qwsogvtv82FCd",
            name: "Bitcoin",
            price: "97217.3",
            symbol: "BTC",
            iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
            change: "2.09",
            marketCap: "4242321",
            volume24h: "52353",
            rank: 1,
            listedAt: 342132332,
            sparkline: ["95631.83", nil, "96020.65"]
        )
    }

    override func tearDown() {
        sampleCoin = nil
        super.tearDown()
    }

    func testSparklineDataConversion() {
        let expectedSparkline = [95631.83, 96020.65] // Should remove `nil` and convert correctly
        XCTAssertEqual(sampleCoin.sparklineData, expectedSparkline, "Sparkline data conversion failed.")
    }
    
    func testMarketCapitalizationConversion() {
        XCTAssertEqual(sampleCoin.marketCapitalization, 4242321.0, "Market capitalization conversion failed.")
    }

    func testHourlyVolConversion() {
        XCTAssertEqual(sampleCoin.hourlyVol, 52353.0, "Hourly volume conversion failed.")
    }

}

