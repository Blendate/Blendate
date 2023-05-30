//
//  Name.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

struct Name: Property {
    var first: String
    var last: String
    
    var valueLabel: String { first }
    
    var isValid: Bool { !first.isEmpty}
    
    static let systemImage = "person.text.rectangle"
}

extension Name {

    struct PropertyView: PropertyViewProtocol {
        typealias P = Name
        var value: Binding<Name>
        var isFilter: Bool = false

        var body: some View {
            VStack{
                TFView(placeholder: "First Name", field: value.first)
                TFView(placeholder: "Last Name", field: value.last)
                Text("Last name's help build authenticity, only your first name will be shown")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 60)
                Spacer()
            }
            .padding(.top)

        }
        struct TFView: View {

            let placeholder: String
            @Binding var field: String

            var body: some View {
                TextField(placeholder, text: $field)
                    .foregroundColor(.Blue)
                    .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .center)
                    .background(Rectangle()
                        .foregroundColor(.DarkBlue)
                        .frame( height: 1, alignment: .center)
                        .offset( y: 15)
                    )
                    .padding(10)
            }
        }
    }
}

struct Name_Previews: PreviewProvider {
    @State static var name: Name = .init(first: "Alice", last: "Turring")
    
    static var previews: some View {
        Name.PropertyView(value: $name)
        PropertyView(Name.self, view: .init(value: $name) )
    }
}
