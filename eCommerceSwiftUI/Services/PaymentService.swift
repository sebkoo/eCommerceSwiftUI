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
        // Simulating a backend call that returns client secret
        return PaymentIntent(clientSecret: "mock_client_secret_test")
    }
}
