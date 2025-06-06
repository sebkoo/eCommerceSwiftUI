//
//  AuthService.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

protocol AuthServiceProtocol {
    func login(username: String, password: String) async throws -> String
}

struct AuthService: AuthServiceProtocol {
    func login(username: String, password: String) async throws -> String {
        let url = URL(string: "https://fakestoreapi.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        return response.token
    }
}
