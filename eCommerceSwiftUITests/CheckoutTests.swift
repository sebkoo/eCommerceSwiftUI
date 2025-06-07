//
//  CheckoutTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class CheckoutTests: XCTestCase {
    func test_createPaymentIntent_success() async throws {
        let service = MockPaymentService()
        let result = try await service.createPaymentIntent(amount: 99.99)
        XCTAssertEqual(result.clientSecret, "mock_secret")
    }

    func test_createPaymentIntent_failure() async {
        let service = MockPaymentService()
        service.shouldFail = true

        do {
            _ = try await service.createPaymentIntent(amount: 99.99)
            XCTFail("Expected failure")
        } catch {
            // success
        }
    }
}
