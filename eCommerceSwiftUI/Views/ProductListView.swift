//
//  ProductListView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct ProductListView: View {
    @State private var products: [Product] = []

    var body: some View {
        NavigationView {
            List(products) { product in
                Text(product.title)
            }
            .navigationTitle(Text("Product List"))
            .task {
                do {
                    products = try await ProductService().fetchProducts()
                } catch {
                    print("Error fetching products: \(error)")
                }
            }
        }
    }
}

#Preview {
    ProductListView()
}
