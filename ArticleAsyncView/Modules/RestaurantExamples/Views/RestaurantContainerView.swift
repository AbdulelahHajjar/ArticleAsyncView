//
//  RestaurantContainerView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 31/05/2024.
//

import SwiftUI

struct RestaurantContainerView: View {
    var body: some View {
        AsyncView(
            request: { try await RestaurantsService.getMainRestaurant() }
        ) { restaurant in
            RestaurantView(restaurant: restaurant)
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    RestaurantContainerView()
}
