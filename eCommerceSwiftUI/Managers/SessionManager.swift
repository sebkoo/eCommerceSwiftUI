//
//  SessionManager.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

@MainActor
final class SessionManager: ObservableObject {
    @Published var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: "auth_token")
        }
    }

    init() {
        self.token = UserDefaults.standard.string(forKey: "auth_token")
    }

    func logout() {
        token = nil
        UserDefaults.standard.removeObject(forKey: "auth_token")
    }
}
