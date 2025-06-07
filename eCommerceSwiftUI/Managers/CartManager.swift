//
//  CartManager.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

@MainActor
final class CartManager: ObservableObject {
    @Published private(set) var items: [CartItem] = []

    private let storage: CartStorageProtocol

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }

    init(storage: CartStorageProtocol = CartStorage()) {
        self.storage = storage
        self.items = storage.loadCart()
    }

    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(id: product.id, product: product, quantity: 1))
        }
        storage.saveCart(items)
    }

    func removeFromCart(_ product: Product) {
        items.removeAll() { $0.product.id == product.id }
        storage.saveCart(items)
    }

    func updateQuantity(for product: Product, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }

        if quantity <= 0 {
            removeFromCart(product)
        } else {
            items[index].quantity = quantity
        }
    }

    func getQuantity(for product: Product) -> Int {
        items.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    func clearCart() {
        items.removeAll()
        storage.saveCart(items)
    }
}
