//
//  ProductDetailViewModel.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import Foundation

@MainActor
final class ProductDetailViewModel: ObservableObject {
    let product: Product

    init(product: Product) {
        self.product = product
    }

    var formattedPrice: String {
        String(format: "$%.2f", product.price)
    }

    var ratingStarts: String {
        String(repeating: "⭐️", count: Int(product.rating.rate.rounded()))
    }
}
