//
//  AccountView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct AccountView: View {
    @State private var user: User?
    @State private var isLoading = true
    @State private var errorMessage: String?

    @EnvironmentObject var session: SessionManager

    let userService: UserServiceProtocol

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                if isLoading {
                    ProgressView("Loading user...")
                } else if let user = user {
                    Text("👋 Hello, \(user.name.firstname) \(user.name.lastname)")
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("📧 \(user.email)")
                        Text("🏙️ \(user.address.city), \(user.address.street)")
                        Text("🧑‍💻 \(user.username)")
                    }

                    Button("Logout") {
                        session.logout()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 20)
                } else if let errorMessage = errorMessage {
                    Text("❌ \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle("Account")
        }
        .task {
            await loadUser()
        }
    }

    private func loadUser() async {
        do {
            // This is hardcoded for demo user.
            // Normally, you'd decode the token to get userID.
            self.user = try await userService.fetchUser(by: 1)
        } catch {
            self.errorMessage = "Failed to fetch user"
        }
        self.isLoading = false
    }
}

#Preview {
    AccountView(userService: UserService())
        .environmentObject(SessionManager())
}
