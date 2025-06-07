//
//  CartItem.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

struct CartItem: Identifiable, Codable, Equatable {
    let id: Int
    let product: Product
    var quantity: Int

    var totalPrice: Double {
        product.price * Double(quantity)
    }
}
