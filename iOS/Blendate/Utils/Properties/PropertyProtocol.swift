//
//  PropertyView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/4/23.
//

import SwiftUI

protocol Property: Codable, Equatable {
    associatedtype PropertyView: PropertyViewProtocol where PropertyView.P == Self
    
    static var title: String { get }
    static var systemImage: String { get }
    static var svgImage: String { get }
    static var label: String { get }
    var valueLabel: String { get }
    var isValid: Bool { get }
}
protocol PropertyViewProtocol: View {
    associatedtype P: Property
    init(value: Binding<P>, isFilter: Bool)
}


extension Property {
    static var title: String { String(describing: Self.self) }
    static var label: String { title }
    static var systemImage: String { "circle" }
    static var svgImage: String { "Family" }

}

extension Property where Self:RawRepresentable, Self.RawValue == String {
    var isValid: Bool { !rawValue.isEmpty }
    var valueLabel: String { rawValue.capitalized }
}

extension Property where Self:RawRepresentable, Self.RawValue == String, Self:CaseIterable {
    var isValid: Bool { rawValue != "none" }
    var valueLabel: String { rawValue == "none" ? String.kOpenString : rawValue.capitalized }
}




struct PropertyGroup: Identifiable {
    var id: String { title }
    let title: String
    let properties: [any Property.Type]
}
extension PropertyGroup {
    
    static let Filters: [PropertyGroup] = [
        PropertyGroup(title:"Personal", properties: [
            Gender.self])
    
    ]
    
}
