//
//  RestaurantsService.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 31/05/2024.
//

import Foundation

final class RestaurantsService {
    static func getMainRestaurant() async throws -> Restaurant {
        try await Task.sleep(for: .seconds(1))
        return Restaurant(
            name: "Restaurant Name",
            address: "321 Awesome St.",
            averageStarsRating: 4.2,
            numberOfRatings: 242,
            deliveryTimeMinutes: 25,
            category: "Fast Food",
            itemCategories: [
                Restaurant.Item.Category(emoji: "🍦", name: "Ice Creams"),
                Restaurant.Item.Category(emoji: "🍞", name: "Bakery"),
                Restaurant.Item.Category(emoji: "🥤", name: "Drinks")
            ],
            items: [
                Restaurant.Item(
                    name: "Ice Cream",
                    description: "If you are reading this..",
                    calories: 140
                ),
                Restaurant.Item(
                    name: "Orange Juice",
                    description: "You are awesome!",
                    calories: 112
                ),
                Restaurant.Item(
                    name: "Bread",
                    description: "Bread is awesome too.",
                    calories: 219
                )
            ]
        )
    }
}
