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
        viewModel = CoinDetailViewModel()
    }

    func testInitialState() {
        XCTAssertNotNil(viewModel.coinDetail)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCoinDetail_Success() {
        let mockResponse = CoinDetailResponse(data: CoinDetail(coin: CoinList.placeholder))
        mockNetworkManager.result = .success(mockResponse)

        viewModel.fetchCoinDetail(uuid: "testUUID")

        XCTAssertTrue(viewModel.isLoading)
        
        let expectation = XCTestExpectation(description: "Fetch coin detail")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
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
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
