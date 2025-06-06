//
//  ProductDetailView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: product.image) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    case .failure:
                        Image(systemName: "xmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(product.title)
                    .font(.title)
                    .bold()

                Text(product.description)
                    .font(.body)

                HStack {
                    Text("⭐️ \(product.rating.rate, specifier: "%.1f")")
                    Text("\(product.rating.count) reviews")
                }
                .font(.caption)
                .foregroundColor(.gray)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .bold()

                Button("Add to Cart") {
                    cartManager.addToCart(product)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}

#Preview {
    ProductDetailView(
        product: Product(
            id: 1,
            title: "Sample",
            price: 10,
            description: "Desc",
            category: "Car",
            image: URL(string: "https://example.com/image.jpg")!,
            rating: .init(rate: 4.0, count: 100)
        )
    ).environmentObject(CartManager())
}
