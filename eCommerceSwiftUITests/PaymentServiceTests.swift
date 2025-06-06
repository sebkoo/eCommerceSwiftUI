//
//  PaymentServiceTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class PaymentServiceTests: XCTestCase {
    func test_createPaymentIntent() async throws {
        let service = PaymentService()
        let intent = try await service.createPaymentIntent(amount: 123.45)
        XCTAssertEqual(intent.clientSecret, "mock_client_secret_test")
    }

}
