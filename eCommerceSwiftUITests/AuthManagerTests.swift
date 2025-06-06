//
//  AuthManagerTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import XCTest
@testable import eCommerceSwiftUI

@MainActor
final class AuthManagerTests: XCTestCase {
    func test_login_logout() {
        let manager = AuthManager()

        XCTAssertFalse(manager.isLoggedIn)

        manager.logIn()
        XCTAssertTrue(manager.isLoggedIn)
        XCTAssertNotNil(manager.user)
        XCTAssertEqual(manager.purchaseHistory.count, 2)

        manager.logOut()
        XCTAssertFalse(manager.isLoggedIn)
        XCTAssertNil(manager.user)
        XCTAssertTrue(manager.purchaseHistory.isEmpty)
    }

}
