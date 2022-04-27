//
//  Filters.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import SwiftUI

struct Filters: Codable {
    var gender: Gender?

    var isParent: Bool = false
    var children: Int?
    var childrenRange: IntRange?
    var maxDistance: Int = 50
    var ageRange = IntRange(18, 65)
    var minHeight: Int = 58
    var relationship: String = "Open to all"
    var familyPlans: String = "Open to all"
    var mobility: String = "Open to all"
    var religion: String = "Open to all"
    var politics: String = "Open to all"
    var ethnicity: String = "Open to all"
    var vices: [String] = []
}


struct IntRange: Codable {
    var min: Int
    var max: Int
    
    init(_ min: Int, _ max: Int){
        self.min = min
        self.max = max
    }
}


//enum Property: String, Codable, CaseIterable, Identifiable {
//    var id: String { self.rawValue }
//    case none = "Open to all"
//
//}
struct EnumPicker: View {
    let property: [String]
    @Binding var value: String
    var body: some View {
        Picker("", selection: $value) {
            ForEach(property, id: \.self) {
                Text($0)
                    .tag($0)
            }
        }
    }
}
