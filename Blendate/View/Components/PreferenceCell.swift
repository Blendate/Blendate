//
//  PreferenceCell.swift
//  Blendate
//
//  Created by Michael on 8/16/21.
//

import SwiftUI

struct PreferenceCell: View {
//    @EnvironmentObject var state: AppState
    let title: String
    var value: String?
//    let toggle: Bool
    let cell: Pref
    let isAccount: Bool
    var userPreferences: UserPreferences?
    
    
    init(_ cell: Pref, _ pref: UserPreferences?) {
        self.cell = cell
        self.userPreferences = pref
        isAccount = false
        title = cell.rawValue
        value = getValue(cell, pref)

    }
    
    init(_ title: String){
        self.title = title
        cell = .name
        value = nil
        isAccount = true

    }
    
    var body: some View {
        NavigationLink(
            destination: getSheet(cell),
            label: {
                VStack {
                    HStack {
                        Text(title)
                            .foregroundColor(title == "Logout" ? .red:.gray)
                        Spacer()
                        if let value = value {
                            if value.isEmpty {
                                Text("--")
                                    .foregroundColor(.DarkBlue)
                            } else {
                                Text(value)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.DarkBlue)
                            }
                            if title != "Email" {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.Blue)
                            }
                        } else {
                            if title == "Push Notifiations" || title == "Invisble Blending" {
                                Toggle("", isOn: .constant(false))
                                    .toggleStyle(SwitchToggleStyle(tint: .Blue))
                            } else {
                                Text(isAccount ?  "":"--")
                                    .foregroundColor(.DarkBlue)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(title == "Logout" ? .red:.Blue)
                            }
                        }
                    }
                    Divider()
                }.padding(.bottom)
            })

    }
    
    
}

//struct PreferenceCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PreferenceCell(title: <#String#>, value: <#String?#>, action: <#() -> Void#>)
//    }
//}
