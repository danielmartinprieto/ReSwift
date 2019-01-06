//
//  StoreInitializationTests.swift
//  ReSwift
//
//  Created by Daniel Martín Prieto on 06/01/2019.
//  Copyright © 2019 Benjamin Encz. All rights reserved.
//

import XCTest
import ReSwift

private struct Value: Equatable {
    var value: Int

    init(_ value: Int) {
        self.value = value
    }
}

private struct State: StateType, Equatable {
    var valA: Value?
    var valB: Value
}

class StoreInitializationTests: XCTestCase {

    func testStoreGetsInitializedProperly() {
        let initialA = Value(0)
        let initialB = Value(1)
        let reducerA: (Action, Value?) -> Value? = { _, state in state ?? initialA }
        let reducerB: (Action, Value?) -> Value = { _, state in state ?? initialB }
        let reducer: (Action, State?) -> State = { action, state in
            State(valA: reducerA(action, state?.valA), valB: reducerB(action, state?.valB))
        }
        let preState = State(valA: nil, valB: Value(1))
        let store = Store(reducer: reducer, state: preState)
        let initialState = State(valA: initialA, valB: initialB)
        XCTAssertEqual(store.state, initialState)
    }

}
