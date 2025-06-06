//
//  MainView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var cartManager = CartManager()

    var body: some View {
        TabView {
            ProductListView(viewModel: ProductListViewModel(service: ProductService()))
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(cartManager.items.reduce(0) { $0 + $1.quantity })
        }
        .environmentObject(cartManager)
    }
}

#Preview {
    MainView()
}
