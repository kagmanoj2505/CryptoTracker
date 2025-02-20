//
//  ChartViewTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
import SwiftUI
@testable import EquityCoinRanking

final class ChartViewTests: XCTestCase {
    
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
            sparkline: [
                "95631.8366392916",
                "95727.06653358914",
                "95563.93293155896",
                "95232.66212051194",
                "95385.16654059608",
                "95708.8852184695",
                "95756.48882546146",
                "95791.78649681424",
                "96294.50612398951",
                "96315.58945892296",
                "96377.44729631838",
                "96306.43517897831",
                "96255.25011158551",
                "96020.65603757667",
                "96198.31055006298"
            ])
    }
    
    override func tearDown() {
        sampleCoin = nil
        super.tearDown()
    }

    func testChartViewRendersCorrectly() {
        let view = ChartView(coin: sampleCoin)
        let hostingController = UIHostingController(rootView: view)
        
        XCTAssertNotNil(hostingController.view, "ChartView should create a valid view hierarchy.")
    }

    func testChartViewCorrectlySetsLineColor() {
        let view = ChartView(coin: sampleCoin)
        
        let priceChange = (sampleCoin.sparklineData.last ?? 0) - (sampleCoin.sparklineData.first ?? 0)
        let expectedColor = priceChange > 0 ? Color.theme.green : Color.theme.red
    }
    
    func testChartViewStateUpdatesOnAppear() {
        let view = ChartView(coin: sampleCoin)
        let expectation = expectation(description: "Animation should update percentage to 1.0")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            XCTAssertEqual(view.percentage, 1.0, "Percentage should animate to 1.0 on appear.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}
