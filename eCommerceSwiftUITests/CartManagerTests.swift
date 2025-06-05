//
//  CartManagerTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI


@MainActor
final class CartManagerTests: XCTestCase {
    func test_addToCart_increasesQuantity() {
        let manager = CartManager()
        manager.clearCart()

        let product = Product(
            id: 99,
            title: "Test",
            price: 1.0,
            description: "Test",
            category: "Test",
            image: URL(string: "https://test.com")!,
            rating: .init(rate: 0, count: 0)
        )

        manager.addToCart(product)
        manager.addToCart(product)

        let item = manager.items.first(where: { $0.product.id == product.id })
        XCTAssertEqual(item?.quantity, 2)
    }

    func test_removeFromCart_deletesItem() {
        let manager = CartManager()
        manager.clearCart()

        let product = Product(
            id: 100,
            title: "DeleteTest",
            price: 1.0,
            description: "Test",
            category: "Test",
            image: URL(string: "https://test.com")!,
            rating: .init(rate: 0, count: 0)
        )

        manager.addToCart(product)
        let item = manager.items.first!
        manager.removeFromCart(item)

        XCTAssertTrue(manager.items.isEmpty)
    }
}
