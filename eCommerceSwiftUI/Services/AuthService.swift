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
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = ["username": username, "password": password]
        request.httpBody = try JSONEncoder().encode(payload)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(AuthResponse.self, from: data)
        return result.token
    }
}
