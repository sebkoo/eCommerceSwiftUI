//
//  ProductListViewModel.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""

    private let service: ProductServiceProtocol

    var filteredProducts: [Product] { searchQuery.isEmpty
        ? products
        : products.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
    }

    init(service: ProductServiceProtocol) {
        self.service = service
    }

    func fetchProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await service.fetchProducts()
            self.products = result
        } catch {
            self.errorMessage = "Failed to load products: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
