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
            UserDefaults.standard.set(token, forKey: "auth_token")
        }
    }

    @Published var isLoggedIn: Bool = false

    init() {
        isLoggedIn = token != nil
        self.token = UserDefaults.standard.string(forKey: "auth_token")
    }

    func logout() {
        token = nil
        UserDefaults.standard.removeObject(forKey: "auth_token")
    }
}
