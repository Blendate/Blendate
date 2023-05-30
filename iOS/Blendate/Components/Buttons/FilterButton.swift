//
//  FilterButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/17/23.
//

import SwiftUI


struct FilterButton: View {
    @State private var showFilters = false
    
    var body: some View {
        ProfileButtonLong(title: "Filters", systemImage: "slider.horizontal.3" ) {
            showFilters = true
        }
        .sheet(isPresented: $showFilters) {
            FiltersView()
        }
    }
    
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
    }
}
