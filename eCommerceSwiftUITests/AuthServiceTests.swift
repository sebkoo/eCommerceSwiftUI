//
//  AuthServiceTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class AuthServiceTests: XCTestCase {
    func test_login_success() async throws {
        let service = AuthService()
        let token = try await service.login(username: "mor_2314", password: "83r5^_")
        XCTAssertFalse(token.isEmpty)
    }

    func test_login_failure() async throws {
        let service = AuthService()

        do {
            _ = try await service.login(username: "invalid", password: "wrong")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error.localizedDescription.contains("data"))
        }
    }
}
