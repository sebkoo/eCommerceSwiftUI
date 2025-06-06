//
//  ProductListViewModel.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation
import Combine

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""
    @Published private(set) var filteredProducts: [Product] = []

    private let service: ProductServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: ProductServiceProtocol) {
        self.service = service
        observeSearchQuery()
    }

    func fetchProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await service.fetchProducts()
            self.products = result
            self.filteredProducts = result
        } catch {
            self.errorMessage = "Failed to load products: \(error.localizedDescription)"
        }

        isLoading = false
    }

    private func observeSearchQuery() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }

                if query.isEmpty {
                    self.filteredProducts = self.products
                } else {
                    self.filteredProducts = self.products.filter {
                        $0.title.localizedCaseInsensitiveContains(query)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
