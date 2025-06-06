//
//  FavoritesView.swift
//  eCommerceSwiftUI
//
//  Created by Bonmyeong Koo - Vendor on 6/6/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(favoritesManager.favorites)) { product in
                    NavigationLink(destination: ProductDetailView(
                        viewModel: ProductDetailViewModel(
                            product: product))
                    ) {
                        Text(product.title)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
