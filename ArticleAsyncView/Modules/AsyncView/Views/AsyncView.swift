//
//  AsyncView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 31/05/2024.
//

import SwiftUI

struct AsyncView<Response, Content: View>: View {
    @State private var response: AsyncValue<Response> = .idle
    
    let mockResponse: Response
    let request: () async throws -> Response
    @ViewBuilder let content: (Response) -> Content
    
    var body: some View {
        responseView
            .task {
                await loadResponseIfPossible()
            }
    }
}

// MARK: - SUBVIEWS
extension AsyncView {
    @ViewBuilder var responseView: some View {
        switch response {
            case .loaded, .loading, .idle:
                let isLoading = response.isLoading
                content(response.loadedValue ?? mockResponse)
                    .redacted(reason: isLoading ? .placeholder : [])
                    .allowsHitTesting(isLoading ? false : true)
            case .failed(let error):
                failureView(error: error)
        }
    }
    
    private func failureView(error: Error) -> some View {
        VStack {
            ContentUnavailableView(
                getBestPossibleTitle(for: error),
                systemImage: "wifi.exclamationmark",
                description: Text(getBestPossibleDescription(for: error))
            )
            .fixedSize(horizontal: false, vertical: true)
            Button("Retry") {
                Task { await loadResponseIfPossible() }
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
}

// MARK: - INITIALIZERS
extension AsyncView where Response: Mockable {
    init(
        request: @escaping () async throws -> Response,
        @ViewBuilder content: @escaping (Response) -> Content
    ) {
        self.mockResponse = Response.makeMock()
        self.request = request
        self.content = content
    }
}

// MARK: - HELPERS
extension AsyncView {
    private func getBestPossibleTitle(for error: Error) -> String {
        let nsError = error as NSError
        if let localizedFailureReason = nsError.localizedFailureReason {
            return localizedFailureReason
        }
        return "An Error Occurred"
    }
    
    private func getBestPossibleDescription(for error: Error) -> String {
        let nsError = error as NSError
        if let localizedRecoverySuggestion = nsError.localizedRecoverySuggestion {
            return localizedRecoverySuggestion
        }
        return error.localizedDescription
    }
    
    private func loadResponseIfPossible() async {
        guard !response.isLoading else { return }
        do {
            try Task.checkCancellation()
            withAnimation { self.response = .loading }
            let response = try await request()
            withAnimation { self.response = .loaded(response) }
        } catch {
            withAnimation { self.response = .failed(error) }
        }
    }
}

#Preview {
    // Example usage
    AsyncView(
        mockResponse: Restaurant.makeMock(),
        request: { try await RestaurantsService.getMainRestaurant() }
    ) { _ in
        Text("Hi there! This Text should be replaced by the RestaurantView")
    }
}
