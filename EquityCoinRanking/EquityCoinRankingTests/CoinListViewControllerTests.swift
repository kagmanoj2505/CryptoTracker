//
//  CoinListViewControllerTests.swift
//  EquityCoinRankingTests
//
//  Created by Kag Manoj on 20/2/25.
//

import XCTest
@testable import EquityCoinRanking

class CoinListViewControllerTests: XCTestCase {
    var viewController: CoinListViewController!
    var mockFavoritesManager: MockFavoritesManager!
    
    override func setUp() {
        super.setUp()
        mockFavoritesManager = MockFavoritesManager()
        viewController = CoinListViewController()
    }
    
    func testFavoriteAction() {        
        // Test adding to favorites
//        viewController.handleFavoriteAction(for: coin, isFavorite: false)
//        XCTAssertTrue(mockFavoritesManager.isFavorite(coin))
        
        // Test removing from favorites
//        viewController.handleFavoriteAction(for: coin, isFavorite: true)
//        XCTAssertFalse(mockFavoritesManager.isFavorite(coin))
    }
}
