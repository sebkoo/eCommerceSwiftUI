//
//  LoginView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isLoading = false

    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var authManager: AuthManager

    let authService: AuthServiceProtocol

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Login") {
                    Task { await login() }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    private func login() async {
        errorMessage = nil
        isLoading = true

        do {
            let token = try await authService.login(username: username, password: password)
            session.saveToken(token)
            try await authManager.loadUser(from: token)
        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

#Preview {
    LoginView(authService: AuthService())
        .environmentObject(SessionManager())
        .environmentObject(AuthManager())
}
