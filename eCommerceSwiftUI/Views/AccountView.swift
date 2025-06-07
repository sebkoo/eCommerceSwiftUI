//
//  AccountView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationView {
            if authManager.isLoggedIn {
                List {
                    Section(header: Text("Profile")) {
                        if let user = authManager.user {
                            Text("👤 \(user.name)")
                            Text("✉️ \(user.email)")
                        } else {
                            Text("No user info available")
                        }
                    }

                    Section(header: Text("Purchase History")) {
                        if authManager.purchaseHistory.isEmpty {
                            Text("No purchases yet.")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(authManager.purchaseHistory) { item in
                                VStack(alignment: .leading) {
                                    Text(item.productName)
                                    Text("$\(item.price, specifier: "%.2f") • \(item.date.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }

                    Section {
                        Button("Log Out", role: .destructive) {
                            authManager.logOut()
                        }
                    }
                }
                .navigationTitle("My Account")
            } else {
                VStack {
                    Text("Welcome to eCommerce")
                        .font(.title2)
                    NavigationLink("Log In", destination: LoginView(authService: AuthService()))
                        .buttonStyle(.borderedProminent)
                }
                .navigationTitle("My Account")
            }
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthManager())
}
