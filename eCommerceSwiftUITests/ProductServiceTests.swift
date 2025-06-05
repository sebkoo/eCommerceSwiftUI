//
//  eCommerceSwiftUITests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class ProductServiceTests: XCTestCase {
    var service: ProductServiceProtocol!

    override func setUp() {
        super.setUp()
        service = ProductService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func test_fetchProducts_returnsProducts() async throws {
        let products = try await service.fetchProducts()
        XCTAssertFalse(products.isEmpty, "Products should not be empty")
        XCTAssertEqual(products.first?.id, 1, "First product ID should be 1")
    }

}
