//
//  CoinDetailViewModelTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
import Combine
@testable import EquityCoinRanking

final class CoinDetailViewModelTests: XCTestCase {
    var viewModel: CoinDetailViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
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

        viewModel = CoinDetailViewModel(coin: mockCoin, networkManager: mockNetworkManager)
    }

    func testInitialState() {
        XCTAssertNotNil(viewModel.coinDetail)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCoinDetail_Success() {
        let mockCoin = CoinList(
            uuid: "534345",
            name: "BTC",
            price: "60000",
            symbol: "YTC",
            iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
            change: "1.43",
            marketCap: "34234232",
            volume24h: "32132",
            rank: 3,
            listedAt: 32211.21,
            sparkline: []
        )
        
        let mockResponse = CoinDetailResponse(data: CoinDetail(coin: mockCoin))
        mockNetworkManager.result = .success(mockResponse)

        viewModel.fetchCoinDetail(uuid: "testUUID")

        XCTAssertTrue(viewModel.isLoading)
        
        let expectation = XCTestExpectation(description: "Fetch coin detail")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.coinDetail?.price, "60000")
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testFetchCoinDetail_Failure() {
        mockNetworkManager.result = .failure(.noInternet)

        viewModel.fetchCoinDetail(uuid: "testUUID")

        XCTAssertTrue(viewModel.isLoading)

        let expectation = XCTestExpectation(description: "Fetch coin detail failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.errorMessage, "Internet not Available.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
