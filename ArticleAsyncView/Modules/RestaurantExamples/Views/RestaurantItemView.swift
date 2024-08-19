//
//  RestaurantItemView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 01/06/2024.
//

import SwiftUI

struct RestaurantItemView: View {
    let item: Restaurant.Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .bold()
                Text(item.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack(spacing: 4) {
                Text(Int(item.calories), format: .number)
                Text("Calories")
                    .unredacted()
            }
            .foregroundStyle(.indigo)
            .font(.caption2)
            .bold()
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 8)
    }
}

#Preview {
    RestaurantItemView(
        item: Restaurant.Item(
            name: "Name",
            description: "Description",
            calories: 100
        )
    )
}
