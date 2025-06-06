//
//  UserService.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUser(by id: Int) async throws -> User
}

struct UserService: UserServiceProtocol {
    func fetchUser(by id: Int) async throws -> User {
        let url = URL(string: "https://fakestoreapi.com/users/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(User.self, from: data)
    }
}
