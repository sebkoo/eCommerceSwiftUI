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

    func loadUser(from token: String) async throws {
        guard let userId = decodeJWT(token: token) else {
            throw URLError(.badServerResponse)
        }

        let url = URL(string: "https://fakestoreapi.com/users/\(userId)")!
        let (data, _) = try await URLSession.shared.data(from: url)

        let fetchedUser = try JSONDecoder().decode(User.self, from: data)
        self.user = fetchedUser
        self.isLoggedIn = true

        self.purchaseHistory = [
            Purchase(id: UUID(), productName: "Mock Purchase A", price: 25.0, date: .now),
            Purchase(id: UUID(), productName: "Mock Purchase B", price: 40.0, date: .now)
        ]
    }

    func logOut() {
        isLoggedIn = false
        user = nil
        purchaseHistory = []
    }

    private func decodeJWT(token: String) -> Int? {
        let segments = token.split(separator: ".")
        guard segments.count == 3 else { return nil }

        let payload = segments[1]
        var base64 = payload.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 += "="
        }

        guard let data = Data(base64Encoded: base64),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let userId = json["sub"] as? Int else {
            return nil
        }
        
        return userId
    }
}
