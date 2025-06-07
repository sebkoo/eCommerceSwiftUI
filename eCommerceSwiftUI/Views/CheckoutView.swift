//
//  CheckoutView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) private var dismiss

    let paymentService: PaymentServiceProtocol
    @State private var isProcessing = false
    @State private var message: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            Text(item.product.title)
                            Spacer()
                            Text("x\(item.quantity)")
                        }
                    }

                    HStack {
                        Text("Total")
                        Spacer()
                        Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                            .bold()
                    }
                }

                if let message = message {
                    Text(message)
                        .foregroundColor(.green)
                        .bold()
                }

                Button("Pay with Stripe (Test)") {
                    Task {
                        await pay()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isProcessing)
            }
            .navigationTitle("Checkout")
        }
    }

    private func pay() async {
        isProcessing = true
        message = nil

        do {
            let intent = try await paymentService.createPaymentIntent(amount: cartManager.totalPrice)
            print("💳 Stripe client secret: \(intent.clientSecret)")

            // In real Stripe integration: use Stripe iOS SDK to confirm payment with `intent.clientSecret`.
            message = "✅ Payment successful (simulated)"
            cartManager.clearCart()
            dismiss()
        } catch {
            message = "❌ Payment failed"
        }

        isProcessing = false
    }
}

#Preview {
    CheckoutView(paymentService: PaymentService())
        .environmentObject(CartManager())
}
