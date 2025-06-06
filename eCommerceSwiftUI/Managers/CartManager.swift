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

    var total: Double {
        items.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
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

    func removeFromCart(_ item: CartItem) {
        items.removeAll() { $0.id == item.id }
        storage.saveCart(items)
    }

    func clearCart() {
        items.removeAll()
        storage.saveCart(items)
    }
}
