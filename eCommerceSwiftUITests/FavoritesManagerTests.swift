//
//  FavoritesManagerTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import XCTest
@testable import eCommerceSwiftUI

@MainActor
final class FavoritesManagerTests: XCTestCase {
    func test_toggleFavorites() {
        let manager = FavoritesManager()
        let product = Product.mock

        XCTAssertFalse(manager.isFavorite(product))
        manager.toggleFavorite(product)
        XCTAssertTrue(manager.isFavorite(product))
        manager.toggleFavorite(product)
        XCTAssertFalse(manager.isFavorite(product))
    }

}
