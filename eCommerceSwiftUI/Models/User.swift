//
//  User.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let username: String
    let name: Name
    let address: Address

    struct Name: Codable {
        let firstname: String
        let lastname: String
    }

    struct Address: Codable {
        let city: String
        let street: String
    }
}
