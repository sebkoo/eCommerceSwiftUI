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

    private let service: ProductServiceProtocol

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
