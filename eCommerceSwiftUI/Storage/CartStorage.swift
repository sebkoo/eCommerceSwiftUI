//
//  CartStorage.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

protocol CartStorageProtocol {
    func saveCart(_ items: [CartItem])
    func loadCart() -> [CartItem]
}

struct CartStorage: CartStorageProtocol {
    private let key = "cart_items"

    func saveCart(_ items: [CartItem]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("❌ Failed to save cart: \(error)")
        }
    }

    func loadCart() -> [CartItem] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([CartItem].self, from: data)
        } catch {
            print("❌ Failed to load cart: \(error)")
            return []
        }
    }
}
