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
            List {
                ForEach(cartManager.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.product.title).lineLimit(1)
                            Text("$\(item.product.price, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Stepper(value: Binding(
                            get: { item.quantity },
                            set: { cartManager.updateQuantity(for: item.product, quantity: $0) }
                        ), in: 0...99) {
                            Text("Qty: \(item.quantity)")
                        }
                    }
                }

                if !cartManager.items.isEmpty {
                    HStack {
                        Text("Total:")
                        Spacer()
                        Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                            .bold()
                    }
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
