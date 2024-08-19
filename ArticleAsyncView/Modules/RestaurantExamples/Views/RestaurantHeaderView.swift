//
//  RestaurantHeaderView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 31/05/2024.
//

import SwiftUI

struct RestaurantHeaderView: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            headerImage
            VStack(alignment: .leading, spacing: 6) {
                titleView
                subtitleView
            }
            HStack {
                informationCell(title: "Delivery", value: "\(Int(restaurant.deliveryTimeMinutes)) Minutes")
                Spacer()
                Divider()
                Spacer()
                informationCell(title: "Category", value: .init(restaurant.category))
            }
            .frame(height: 24)
        }
    }
}

// MARK: - VIEWS
extension RestaurantHeaderView {
    // This would be dynamic coming from the `restaurant` object, but for the simplicity of the tutorial, it is static here.
    var headerImage: some View {
        Image(.restaurant)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 180)
            .clipped()
            .padding(.horizontal, -20)
    }
    
    var titleView: some View {
        Text(restaurant.name)
            .font(.title2)
            .bold()
            .padding(.leading, 2)
    }
    
    var subtitleView: some View {
        HStack {
            ratingsView
            Text("-")
            addressView
                .foregroundStyle(.secondary)
        }
        .font(.body)
    }
    
    var ratingsView: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .foregroundStyle(.indigo)
                .unredacted()
            Text("\(restaurant.averageStarsRating.formatted(.number)) (\(restaurant.numberOfRatings))")
        }
    }
    
    var addressView: some View {
        Text(restaurant.address)
    }
    
    func informationCell(
        title: LocalizedStringKey,
        value: LocalizedStringKey
    ) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .foregroundStyle(.indigo)
                .font(.caption)
                .unredacted()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    RestaurantHeaderView(restaurant: .makeMock())
}
