//
//  User.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/5/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: Name
    let email: String
    let username: String

    struct Name: Codable {
        let firstname: String
        let lastname: String
    }

    var fullName: String {
        "\(name.firstname.capitalized) \(name.lastname.capitalized)"
    }
}
