//
//  Restaurant+Item.swift
//  ArticleAsyncView
//
//  Created by Abdulelah Hajjar on 19/08/2024.
//

import Foundation

extension Restaurant {
    struct Item: Hashable {
        let name: String
        let description: String
        let calories: Double
    }
}
