//
//  RegisterView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var authManager: AuthManager

    let authService: AuthServiceProtocol

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account Info")) {
                    TextField("User Name", text: $username)
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }

                Section(header: Text("Personal Info")) {
                    TextField("Full Name", text: $name)
                    TextField("Phone", text: $phone)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Register") {
                    Task { await register() }
                }
                .disabled(isLoading)
            }
            .navigationTitle("Register")
        }
    }

    private func register() async {
        isLoading = true
        errorMessage = nil

        let nameParts = name.split(separator: " ", maxSplits: 1).map(String.init)
        let firstName = nameParts.first ?? ""
        let lastName = nameParts.count > 1 ? nameParts[1] : ""

        let newUser = RegisterRequest(
            email: email,
            username: username,
            password: password,
            name: Name(firstname: firstName, lastname: lastName),
            address: Address(
                city: "Seoul",
                street: "Main",
                number: 1,
                zipcode: "12345",
                geolocation: Geolocation(lat: "0", long: "0")
            ),
            phone: phone
        )

        do {
            try await authService.register(newUser: newUser)
            let token = try await authService.login(username: username, password: password)
            session.token = token
            try await authManager.loadUser(from: token)
        } catch {
            errorMessage = "❌ Registration failed: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

#Preview {
    RegisterView(authService: AuthService())
        .environmentObject(SessionManager())
        .environmentObject(AuthManager())
}
