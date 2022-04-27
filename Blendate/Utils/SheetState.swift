//
//  SheetState.swift
//  Blendate
//
//  Created by Michael on 4/7/22.
//

import Foundation

class SheetState<State>: ObservableObject {
    @Published var isShowing = false
    @Published var state: State? {
        didSet { isShowing = state != nil }
    }
}


