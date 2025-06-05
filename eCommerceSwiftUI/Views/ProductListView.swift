//
//  ProductListView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    List(viewModel.products) { product in
                        Text(product.title)
                    }
                }
            }
            .navigationTitle(Text("Product List"))
            .task {
                await viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductListView(viewModel: ProductListViewModel(service: ProductService()))
}
