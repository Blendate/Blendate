//
//  Binding.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI

extension Binding where Value == String? {
    var optionalBinding: Binding<String> {
        .init(
            get: {
                self.wrappedValue ?? ""
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}
extension Binding where Value == Color? {
    var optionalBinding: Binding<Color> {
        .init(
            get: {
                self.wrappedValue ?? Color.Blue
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}

extension Binding where Value == Bool? {
    var optionalBinding: Binding<Bool> {
        .init(
            get: {
                self.wrappedValue ?? false
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}

