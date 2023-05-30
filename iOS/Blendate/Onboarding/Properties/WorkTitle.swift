//
//  WorkTitle.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import SwiftUI

struct Work: Property, RawRepresentable, ExpressibleByStringLiteral {
    var rawValue: String
    
    init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let systemImage = "briefcase"
    static let svgImage = "Work"

    struct PropertyView: PropertyViewProtocol {
        var value: Binding<Work>
        var isFilter: Bool = false
        
        var body: some View {
            DetailField(text: value.rawValue)
        }
    }
}



struct Education: Property, RawRepresentable, ExpressibleByStringLiteral {
    var rawValue: String
    
    init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let systemImage = "graduationcap"
    static let svgImage = "Education"

    struct PropertyView: PropertyViewProtocol {
        var value: Binding<Education>
        var isFilter: Bool = false

        var body: some View {
            DetailField(text: value.rawValue)
        }
    }
}

struct DetailField: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 2)
            .foregroundColor(Color.Blue.opacity(0.5))
        )
        .font(.title)
        .padding(.horizontal,32)
    }
}
