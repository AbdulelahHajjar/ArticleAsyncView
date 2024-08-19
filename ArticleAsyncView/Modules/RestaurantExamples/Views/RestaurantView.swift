//
//  RestaurantView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 01/06/2024.
//

import SwiftUI

struct RestaurantView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                RestaurantHeaderView(restaurant: restaurant)
                Divider()
                itemCategories
                Divider()
                items
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - VIEWS
extension RestaurantView {
    var itemCategories: some View {
        section(title: "Categories") {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(restaurant.itemCategories, id: \.self) { itemCategory in
                        RestaurantCategoryView(
                            emoji: itemCategory.emoji,
                            name: itemCategory.name
                        )
                        .scaleEffect(1)
                    }
                }
            }
            .scrollClipDisabled()
        }
    }
    
    var items: some View {
        section(title: "Items") {
            VStack(spacing: 24) {
                ForEach(restaurant.items, id: \.self) { item in
                    RestaurantItemView(item: item)
                }
            }
        }
    }
    
    private func section<Content: View>(
        title: LocalizedStringKey,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .bold()
                .unredacted()
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Color.pink
        .sheet(isPresented: .constant(true)) {
            RestaurantView(restaurant: .makeMock())
        }
}
