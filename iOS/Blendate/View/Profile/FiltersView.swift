//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session: SessionViewModel
    
    @State var drinking: String = "Open to all"
    @State var smoking: String = "Open to all"
    @State var cannabis: String = "Open to all"

    var isParent: Bool {
        session.user.filters.isParent
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(Detail.FilterGroup.allCases){ group in
                    Section {
                        ForEach(group.cells(isParent: isParent)) { cell in
                            DetailCellView(detail: cell, details: $session.user, type: .filter)
                        }
                    } header: {
                        Text(group.id)
                    }.textCase(nil)

                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") {
                    dismiss()
                }
            }

        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
