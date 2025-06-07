//
//  RegisterRequest.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

struct RegisterRequest: Codable {
    let email: String
    let username: String
    let password: String
    let name: Name
    let address: Address
    let phone: String
}

struct Name: Codable {
    let firstname: String
    let lastname: String
}

struct Address: Codable {
    let city: String
    let street: String
    let number: Int
    let zipcode: String
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let lat: String
    let long: String
}
