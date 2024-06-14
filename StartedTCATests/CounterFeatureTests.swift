//
//  CounterFeatureTests.swift
//  StartedTCATests
//
//  Created by Cuong Nguyen on 6/9/24.
//

import ComposableArchitecture
import XCTest

@testable import StartedTCA

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.timerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        
        await store.send(.timerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
}
