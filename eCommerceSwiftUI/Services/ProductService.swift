//
//  ProductService.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

final class ProductService: ProductServiceProtocol {
    private let baseURL = URL(string: "https://fakestoreapi.com")!

    func fetchProducts() async throws -> [Product] {
        let url = baseURL.appendingPathComponent("/products")
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    }
}
