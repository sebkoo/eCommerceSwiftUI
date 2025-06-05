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

    private let storageKey = "cart_items"

    init() { loadCart() }

    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(id: product.id, product: product, quantity: 1))
        }
        saveCart()
    }

    func removeFromCart(_ item: CartItem) {
        items.removeAll() { $0.id == item.id }
        saveCart()
    }

    func clearCart() {
        items.removeAll()
        saveCart()
    }

    private func saveCart() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let savedItems = try? JSONDecoder().decode([CartItem].self, from: data)
        else { return }

        self.items = savedItems
    }
}
