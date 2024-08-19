//
//  Restaurant.swift
//  ArticleAsyncView
//
//  Created by Abdulelah Hajjar on 19/08/2024.
//

import Foundation

struct Restaurant {
    let name: String
    let address: String
    let averageStarsRating: Double
    let numberOfRatings: Int
    
    let deliveryTimeMinutes: Double
    let category: String
    
    let itemCategories: [Restaurant.Item.Category]
    let items: [Restaurant.Item]
}
