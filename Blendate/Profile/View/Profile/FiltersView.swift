//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var user: User
    
    @State var drinking: String = "Open to all"
    @State var smoking: String = "Open to all"
    @State var cannabis: String = "Open to all"

    var body: some View {
        NavigationView{
            List {
                ForEach(Detail.FilterGroup.allCases){ group in
                    Section {
                        ForEach(group.cells(isParent: user.filters.isParent)) { cell in
                            DetailCellView(detail: cell, user: $user, type: .filter)
                        }
                    } header: {
                        Text(group.id)
                    }.textCase(nil)

                }
            }
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") {
                    dismiss()
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}




struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(user: dev.$bindingMichael)

    }
}
