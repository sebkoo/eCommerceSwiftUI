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
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear") {
                        cartManager.clearCart()
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
