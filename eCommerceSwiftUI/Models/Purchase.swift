//
//  Purchase.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import Foundation

struct Purchase: Identifiable {
    let id: UUID
    let productName: String
    let price: Double
    let date: Date
}
