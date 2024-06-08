//
//  CounterFeature.swift
//  StartedTCA
//
//  Created by Cuong Nguyen on 12/28/23.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading: Bool = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                                .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await(send(.factResponse(fact)))
                }
            case let .factResponse(data):
                state.isLoading = false
                state.fact = data
                return .none
            }
        }
    }
}
