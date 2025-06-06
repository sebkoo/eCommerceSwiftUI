//
//  ProductListViewModelTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

@MainActor
final class ProductListViewModelTests: XCTestCase {
    func test_fetchProducts_success() async {
        let mockService = MockProductService()
        let viewModel = ProductListViewModel(service: mockService)

        await viewModel.fetchProducts()

        XCTAssertFalse(viewModel.products.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.products.first?.title, "Mock Product")
    }

    func test_fetchProducts_failure() async {
        let mockService = MockProductService()
        mockService.shouldReturnError = true
        let viewModel = ProductListViewModel(service: mockService)

        await viewModel.fetchProducts()

        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func test_filterProducts() async throws {
        let mockService = MockProductService()
        let viewModel = ProductListViewModel(service: mockService)

        await viewModel.fetchProducts()
        viewModel.searchQuery = "mock"

        // Allow debounce to process
        try await Task.sleep(nanoseconds: 400_000_000)

        XCTAssertEqual(viewModel.filteredProducts.count, 1)
        XCTAssertEqual(viewModel.filteredProducts.first?.title, "Mock Product")
    }
}
