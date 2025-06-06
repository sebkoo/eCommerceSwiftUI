//
//  AuthManager.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var user: User? = nil
    @Published var purchaseHistory: [Purchase] = []

    func logIn() {
        isLoggedIn = true
        user = User(id: 1, name: "John Appleseed", email: "john@apple.com")
        purchaseHistory = [
            Purchase(id: UUID(), productName: "T-Shirt", price: 20.0, date: .now),
            Purchase(id: UUID(), productName: "Backpack", price: 89.99, date: .now)
        ]
    }

    func logOut() {
        isLoggedIn = false
        user = nil
        purchaseHistory = []
    }
}
