//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Binding var filters: Filters
    
    init(_ filters: Binding<Filters>) {
        ColorNavbar()
        self._filters = filters
    }

    @State var drinking: String = "Open to all"
    @State var smoking: String = "Open to all"
    @State var cannabis: String = "Open to all"

    var body: some View {
        NavigationView{
            GeometryReader { geo in
                List {
                    ForEach(Filter.FilterGroup.allCases){ group in
                        Section(header: Text(group.id).foregroundColor(.DarkBlue)) {
                            ForEach(group.cells(filters)) { cell in
                                FilterCellView(filter: cell, filters: $filters, width: geo.size.width)
                            }
                        }
                        .headerProminence(.increased)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .pickerStyle(MenuPickerStyle())
            .background(Color.LightGray)
            .navigationBarTitle("Filters")
        }
    }
    
}




struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(dev.$bindingMichael.filters)

    }
}
