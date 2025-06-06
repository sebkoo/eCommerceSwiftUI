//
//  ProductDetailView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @ObservedObject var viewModel: ProductDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.product.image) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                    } else {
                        ProgressView()
                            .frame(height: 250)
                    }
                }

                Text(viewModel.product.title)
                    .font(.headline)

                Text(viewModel.formattedPrice)
                    .font(.title)
                    .foregroundColor(.green)

                Text(viewModel.ratingStarts)

                Text(viewModel.product.description)
                    .font(.body)

                Button("Add to Cart") {
                    cartManager.addToCart(viewModel.product)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}

#Preview {
    ProductDetailView(
        viewModel: ProductDetailViewModel(product: .mock)
    ).environmentObject(CartManager())
}
