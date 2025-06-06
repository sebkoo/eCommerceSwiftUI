//
//  UserServiceTests.swift
//  eCommerceSwiftUITests
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import XCTest
@testable import eCommerceSwiftUI

final class UserServiceTests: XCTestCase {
    func testFetchUser() async throws {
        let service = UserService()
        let user = try await service.fetchUser(by: 1)
        XCTAssertEqual(user.id, 1)
        XCTAssertFalse(user.name.isEmpty)
    }
}
