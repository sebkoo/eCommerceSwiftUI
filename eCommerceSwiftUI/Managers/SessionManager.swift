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
    @AppStorage("auth_token") var token: String? {
        didSet {
            isLoggedIn = token != nil
            userId = decodeUseId(from: token)
            UserDefaults.standard.set(token, forKey: "auth_token")
        }
    }

    @Published var isLoggedIn: Bool = false
    @Published var userId: Int?

    init() {
        isLoggedIn = token != nil
        userId = decodeUseId(from: token)
        self.token = UserDefaults.standard.string(forKey: "auth_token")
    }

    func logOut() {
        token = nil
        userId = nil
        UserDefaults.standard.removeObject(forKey: "auth_token")
    }

    private func decodeUseId(from token: String?) -> Int? {
        guard let token = token else { return nil }
        let parts = token.split(separator: ".")
        guard parts.count == 3 else { return nil }

        let payloadData = base64UrlDecode(String(parts[1]))
        guard let payloadData = payloadData else { return nil }

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
