//
//  CartView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            VStack {
                if cartManager.items.isEmpty {
                    Text("🛒 Your cart is empty")
                        .font(.headline)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            HStack {
                                Text(item.product.title)
                                    .lineLimit(1)
                                Spacer()
                                Text("Qty: \(item.quantity)")
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.map { cartManager.items[$0] }
                                .forEach(cartManager.removeFromCart)
                        }
                    }

                    NavigationLink("Proceed to Checkout") {
                        CheckoutView(paymentService: PaymentService())
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if !cartManager.items.isEmpty {
                        Button("Clear") {
                            cartManager.clearCart()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
