//
//  PaymentViewModel.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import Foundation

@MainActor
final class PaymentViewModel: ObservableObject {
    @Published var isProcessing = false
    @Published var clientSecret: String?
    @Published var errorMessage: String?

    private let paymentService: PaymentServiceProtocol

    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }

    func startPayment(amount: Double) async {
        isProcessing = true
        errorMessage = nil

        do {
            let intent = try await paymentService.createPaymentIntent(amount: amount)
            clientSecret = intent.clientSecret
        } catch {
            errorMessage = "Payment failed: \(error.localizedDescription)"
        }

        isProcessing = false
    }
}
