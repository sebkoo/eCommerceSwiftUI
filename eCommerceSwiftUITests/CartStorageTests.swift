//
//  CartStorageTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class CartStorageTests: XCTestCase {
    func test_saveAndLoadCart() {
        let storage = CartStorage()
        let item = CartItem(
            id: 1,
            product: Product(
                id: 1,
                title: "Test Product",
                price: 10.0,
                description: "Sample",
                category: "cat",
                image: URL(string: "https://example.com")!,
                rating: .init(rate: 4.5, count: 20)
            ),
            quantity: 2
        )

        storage.saveCart([item])
        let loaded = storage.loadCart()

        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded.first?.product.title, "Test Product")
        XCTAssertEqual(loaded.first?.quantity, 2)
    }

}
