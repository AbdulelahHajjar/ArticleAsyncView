//
//  RestaurantCategoryView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 01/06/2024.
//

import SwiftUI

struct RestaurantCategoryView: View {
    let emoji: String
    let name: String
    
    var body: some View {
        HStack {
            Text(emoji)
                .frame(width: 32, height: 32)
                .background(.cyan.opacity(0.2))
                .clipShape(Circle())
            Text(name)
                .fontWeight(.semibold)
        }
        .padding(12)
        .padding(.trailing, 2)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 8)
    }
}

#Preview {
    RestaurantCategoryView(
        emoji: "🍦",
        name: "Ice Cream"
    )
}
