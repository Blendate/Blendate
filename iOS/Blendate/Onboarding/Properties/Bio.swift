//
//  Bio.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import SwiftUI

struct Bio: Property, RawRepresentable, ExpressibleByStringLiteral {
    var valueLabel: String { String(rawValue.prefix(25)) + "..." }
    
    var isValid: Bool { rawValue.count > 3 }
    
    var rawValue: String
    
    init(stringLiteral value: String) {
        self.rawValue = value
    }
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    static let systemImage = "note.text"
}
extension Bio {
    struct PropertyView: PropertyViewProtocol {
        @Binding var value: Bio
        var isFilter: Bool = false
        
        let maxLength: Int = 180
        let isTop = true
        
        var body: some View {
            VStack{
                Text("Tell us about yourself, or share your favorite quote.")
                    .font(.title.weight(.semibold), .DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.vertical)
                TextField("Something nice", text: $value.rawValue, axis: .vertical)
                    .lineLimit(6...10)
                    .padding()
                    .overlay(
                      RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.Blue.opacity(0.5))
                    )
                    .padding()
    //                .overlay(
    //                    Text("\(about.count)/\(maxLength)")
    //                        .foregroundColor(.gray)
    //                        .font(.caption)
    //                        .padding(.bottom,20)
    //                        .padding(.trailing,30)
    //                        , alignment: .bottomTrailing
    //                )
                Spacer()
            }
            .padding(.horizontal)
        }
        
    }
}
