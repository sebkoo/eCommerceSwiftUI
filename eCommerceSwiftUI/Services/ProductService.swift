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

final class MockProductService: ProductServiceProtocol {
    var shouldReturnError = false

    func fetchProducts() async throws -> [Product] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        
        return [
            Product(
                id: 1,
                title: "Mock Product",
                price: 9.99,
                description: "Description",
                category: "Category",
                image: URL(string: "https://example.com/image.png")!,
                rating: Product.Rating(rate: 4.5, count: 100)
            )
        ]
    }
}
