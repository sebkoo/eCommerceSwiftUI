//
//  SessionManager.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation
import SwiftUI

@MainActor
final class SessionManager: ObservableObject {
    @Published var token: String?
    @Published var isLoggedIn: Bool = false
    @Published var userId: Int?

    private let keychainService = "com.ecommerce.auth"
    private let keychainAccount = "jwt_token"

    init() {
        if let data = KeychainHelper.load(service: keychainService, account: keychainAccount),
           let storedToken = String(data: data, encoding: .utf8) {
            self.token = storedToken
            self.userId = decodeUseId(from: token)
            self.isLoggedIn = token != nil
        }
    }

    func saveToken(_ newToken: String) {
        self.token = newToken
        self.userId = decodeUseId(from: newToken)
        self.isLoggedIn = true

        let data = Data(newToken.utf8)
        KeychainHelper.save(data, service: keychainService, account: keychainAccount)
    }

    func logOut() {
        self.token = nil
        self.userId = nil
        self.isLoggedIn = false

        KeychainHelper.delete(service: keychainService, account: keychainAccount)
    }

    private func decodeUseId(from token: String?) -> Int? {
        guard let token = token else { return nil }
        let parts = token.split(separator: ".")
        guard parts.count == 3 else { return nil }

        guard let payloadData = base64UrlDecode(String(parts[1]))
        else { return nil }

        struct Payload: Decodable {
            let sub: Int
        }

        return try? JSONDecoder().decode(Payload.self, from: payloadData).sub
    }

    private func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "_", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let padding = 4 - base64.count & 4
        if padding < 4 {
            base64 += String(repeating: "=", count: padding)
        }

        return Data(base64Encoded: base64)
    }
}
