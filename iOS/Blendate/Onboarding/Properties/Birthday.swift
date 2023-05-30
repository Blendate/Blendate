//
//  Birthday.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

struct Birthday: Property {
    var date: Date
    
    var valueLabel: String { date.age.description }
    
    var isValid: Bool { date.timeIntervalSince1970 < Date.youngestBirthday.timeIntervalSince1970 }
    
    static let systemImage = "person.text.rectangle"
}

extension Birthday {

    struct PropertyView: PropertyViewProtocol {
        typealias P = Birthday
        var value: Binding<Birthday>
        var isFilter: Bool = false

        var body: some View {
            DatePicker(selection: value.date,
                       in: ...Date.youngestBirthday,
                       displayedComponents: [.date]) {
                
            }
            .datePickerStyle(.graphical).tint(.Blue)
        }
    }
}

struct Birthday_Previews: PreviewProvider {
    @State static var birthday: Birthday = .init(date: Date.now)
    
    static var previews: some View {
        Birthday.PropertyView(value: $birthday)
        PropertyView(Birthday.self, view: .init(value: $birthday) )
    }
}
