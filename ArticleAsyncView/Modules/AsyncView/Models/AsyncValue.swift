//
//  AsyncValue.swift
//  ArticleAsyncView
//
//  Created by Abdulelah Hajjar on 19/08/2024.
//

import Foundation

enum AsyncValue<Value> {
    case idle
    case loaded(Value)
    case loading
    case failed(Error)
    
    var isLoading: Bool {
        if case .loading = self {
            true
        } else {
            false
        }
    }
    
    var loadedValue: Value? {
        switch self {
            case .loaded(let value):
                return value
            default:
                return nil
        }
    }
}
