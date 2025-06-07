//
//  eCommerceSwiftUIApp.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

@main
struct eCommerceSwiftUIApp: App {
    @StateObject private var session = SessionManager()
    @StateObject private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                MainView()
                    .environmentObject(session)
                    .environmentObject(authManager)
            } else {
                LoginView(authService: AuthService())
                    .environmentObject(session)
                    .environmentObject(authManager)
            }
        }
    }
}
