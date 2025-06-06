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
                        Text("👤 \(authManager.user?.name ?? "")")
                        Text("✉️ \(authManager.user?.email ?? "")")
                    }

                    Section(header: Text("Purchase History")) {
                        ForEach(authManager.purchaseHistory) { item in
                            VStack(alignment: .leading) {
                                Text(item.productName)
                                Text("$\(item.price, specifier: "%.2f") • \(item.date.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
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
                    Button("Log In") {
                        authManager.logIn()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("May Account")
            }
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthManager())
}
