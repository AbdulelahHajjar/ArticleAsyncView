//
//  AsyncView.swift
//  StandardizedNetworkCallsBlog
//
//  Created by Abdulelah Hajjar on 31/05/2024.
//

/*
MIT License

Copyright (c) 2024 Abdulelah Hajjar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
                let isLoaded = response.loadedValue != nil
                content(response.loadedValue ?? mockResponse)
                    .redacted(reason: isLoaded ? [] : .placeholder)
                    .allowsHitTesting(isLoaded)
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
        if case .loading = response {
            return
        }
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
