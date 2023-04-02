//
//  FilterButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/17/23.
//

import SwiftUI

struct FilterButton: View {
    @Binding var user: User
    @Binding var settings: User.Settings
    
    var title: String = "Filters"
    var systemName: String = "slider.horizontal.3"
    var color: Color = .Blue
    
    @State private var show = false
    
    var body: some View {
        Button { show = true }
            label: {
                HStack(alignment: .center) {
                    Image(systemName: systemName)
                    Text(title)
                }
                .padding(.horizontal)
        }
        .shapeButton(shape: .roundedRectangle, color: color)
        .fullScreenCover(isPresented: $show) {
            EditStatsView(user: $user, settings: $settings, isFilter: true)
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(user: .constant(alice), settings: .constant(User.Settings()))
    }
}
