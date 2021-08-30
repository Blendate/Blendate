//
//  EditProfileCell.swift
//  Blendate
//
//  Created by Michael on 8/16/21.
//

import SwiftUI

struct EditProfileCell: View {
    let title: String
    let value: String?
    
    let cell: Pref
    var userPreferences: UserPreferences?

    init(_ cell: Pref, _ pref: UserPreferences?) {
        self.cell = cell
        self.userPreferences = pref
        title = cell.rawValue
        value = getValue(cell, pref)
    }
    
    var body: some View {
        NavigationLink(
            destination: getSheet(cell),
            label: {
                VStack {
                    HStack {
                        Text(title)
                            .foregroundColor(.gray)
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
                        } else {
                            Text("--")
                                .foregroundColor(.DarkBlue)
                        }
                        Image("eye")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.Blue)
                    }
                    Divider()
                }.padding(.bottom)
            })
    }
}

struct EditProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileCell(.gender, Dummy.userPref)
    }
}
