//
//  ProductListView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager
    @EnvironmentObject var cartManager: CartManager

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
                            HStack(spacing: 12) {
                                AsyncImage(url: product.image) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(.body)
                                        .lineLimit(1)
                                    Text("$\(product.price, specifier: "%.2f")")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                VStack(spacing: 8) {
                                    // Wishlist Toggle
                                    Image(systemName: favoritesManager.isFavorite(product)
                                          ? "heart.fill"
                                          : "heart"
                                        )
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            favoritesManager.toggleFavorite(product)
                                        }

                                    // Add to Cart
                                    Image(systemName: "cart.badge.plus")
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            cartManager.addToCart(product)
                                        }
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
        .environmentObject(FavoritesManager())
        .environmentObject(CartManager())
}
