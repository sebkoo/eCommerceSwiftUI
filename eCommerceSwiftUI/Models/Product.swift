//
//  Product.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

struct Product: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
    let rating: Rating

    struct Rating: Codable, Equatable {
        let rate: Double
        let count: Int
    }
}

extension Product {
    static let mock = Product(
        id: 1,
        title: "Swift Sneakers",
        price: 59.99,
        description: "Lightweight and stylish running shoes.",
        category: "shoes",
        image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!,
        rating: .init(rate: 4.5, count: 123))
}
