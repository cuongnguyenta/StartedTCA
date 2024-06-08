//
//  StartedTCAApp.swift
//  StartedTCA
//
//  Created by Cuong Nguyen on 12/28/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct StartedTCAApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: StartedTCAApp.store)
        }
    }
}
