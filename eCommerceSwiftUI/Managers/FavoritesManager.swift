//
//  FavoritesManager.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import Foundation

@MainActor
final class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: Set<Product> = []

    private let saveKey = "favorite_products"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() { loadFavorites() }

    func toggleFavorite(_ product: Product) {
        if favorites.contains(product) {
            favorites.remove(product)
        } else {
            favorites.insert(product)
        }
        saveFavorites()
    }

    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(product)
    }

    private func saveFavorites() {
        if let data = try? encoder.encode(Array(favorites)) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let decoded = try? decoder.decode([Product].self, from: data)
        else { return }

        favorites = Set(decoded)
    }
}
