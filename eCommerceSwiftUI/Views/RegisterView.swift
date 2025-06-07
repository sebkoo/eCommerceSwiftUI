//
//  RegisterView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var authManager: AuthManager

    let authService: AuthServiceProtocol

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)

                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Register") {
                    Task { await register() }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)

                Divider()

                Button("Quick Signup with Google Email") {
//                    Task { await  }
                }
            }
            .padding()
            .navigationTitle("Register")
        }
    }

    private func register() async {
        errorMessage = nil
        isLoading = true

        do {
            let token = try await authService.register(
                name: name,
                email: email,
                username: username,
                password: password
            )

            session.token = token
            try await authManager.loadUser(from: token)
        } catch {
            errorMessage = "Registration failed: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

#Preview {
    RegisterView(authService: AuthService())
        .environmentObject(SessionManager())
        .environmentObject(AuthManager())
}
