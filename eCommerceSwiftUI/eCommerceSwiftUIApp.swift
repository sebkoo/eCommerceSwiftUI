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

    var body: some Scene {
        WindowGroup {
            if let _ = session.token {
                MainView()
                    .environmentObject(session)
            } else {
                LoginView(authService: AuthService())
                    .environmentObject(session)
            }
        }
    }
}
