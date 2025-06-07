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
        let cart = CartManager()
        let product = Product.mock

        cart.addToCart(product)
        cart.addToCart(product)

        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items.first?.quantity, 2)
    }

    func test_updateQuantity_removesItem() {
        let cart = CartManager()
        let product = Product.mock

        cart.addToCart(product)
        cart.updateQuantity(for: product, quantity: 0)

        XCTAssertTrue(cart.items.isEmpty)
    }

    func test_clearCart() {
        let cart = CartManager()
        let product = Product.mock

        cart.addToCart(product)
        cart.clearCart()

        XCTAssertTrue(cart.items.isEmpty)
    }
}
