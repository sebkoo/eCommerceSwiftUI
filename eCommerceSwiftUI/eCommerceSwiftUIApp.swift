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
            Group {
                if session.isLoggedIn {
                    MainView()
                        .environmentObject(session)
                        .environmentObject(authManager)
                        .task {
                            if let token = session.token {
                                try? await authManager.loadUser(from: token)
                            }
                        }
                } else {
                    LoginView(authService: AuthService())
                        .environmentObject(session)
                        .environmentObject(authManager)
                }
            }
        }
    }
}
