//
//  Restaurant+Mockable.swift
//  ArticleAsyncView
//
//  Created by Abdulelah Hajjar on 19/08/2024.
//

import Foundation

extension Restaurant: Mockable {
    static func makeMock() -> Restaurant {
        Restaurant(
            name: "Mock Name",
            address: "Mock Address",
            averageStarsRating: 0,
            numberOfRatings: 0,
            deliveryTimeMinutes: 0,
            category: "Mock Category",
            itemCategories: [
                Restaurant.Item.Category(emoji: "🔄", name: "Mock Category...")
            ],
            items: [
                Restaurant.Item(
                    name: "Mock Item",
                    description: "Mock Description...",
                    calories: 140
                )
            ]
        )
    }
}
