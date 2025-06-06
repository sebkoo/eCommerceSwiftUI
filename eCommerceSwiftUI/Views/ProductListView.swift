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
                    List(viewModel.filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(
                            viewModel: ProductDetailViewModel(
                                product: product))
                        ) {
                            HStack {
                                AsyncImage(url: product.image) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(product.title).lineLimit(1)
                                    Text("$\(product.price, specifier: "%.2f")")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Product List")
            .searchable(text: $viewModel.searchQuery)
            .task {
                await viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductListView(viewModel: ProductListViewModel(service: ProductService()))
}
