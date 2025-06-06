//
//  PaymentService.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

protocol PaymentServiceProtocol {
    func createPaymentIntent(amount: Double) async throws -> PaymentIntent
}

struct PaymentService: PaymentServiceProtocol {
    func createPaymentIntent(amount: Double) async throws -> PaymentIntent {
        let url = URL(string: "https://stripe-backend-74j2.onrender.com")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload = ["amount": amount]
        request.httpBody = try JSONEncoder().encode(payload)

        let (data, _) = try await URLSession.shared.data(for: request)

        // Simulating a backend call that returns client secret
        return try JSONDecoder().decode(PaymentIntent.self, from: data)
    }
}
