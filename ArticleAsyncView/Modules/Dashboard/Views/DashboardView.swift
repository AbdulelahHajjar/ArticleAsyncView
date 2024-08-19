//
//  DashboardView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 01/06/2024.
//

import SwiftUI

struct DashboardView: View {
    @State private var showRestaurant: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to The App")
            Button("Show Restaurant") {
                showRestaurant = true
            }
        }
        .sheet(isPresented: $showRestaurant) {
            RestaurantContainerView()
        }
    }
}

#Preview {
    DashboardView()
}
