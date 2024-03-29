//
//  DetailCells.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/13/23.
//

import SwiftUI
import Sliders

struct DetailCell<Destination:View, Cell: View>:View {
    var title: String?
    var svg: String?
    @ViewBuilder var destination: Destination
    @ViewBuilder var cell: Cell
    
    var body: some View {
        NavigationLink {
            PropertyView(title: title, svg: svg) {
                destination
            }
        } label: {
            cell
        }

    }
}
struct PropertyCell: View {
    let title: String
    let label: String
    var systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(.Purple)
            Text(title)
            Spacer()
            Text(label)
                .foregroundColor(.Blue)
        }
    }
}

extension DetailCell {
    
    init<P:Property>(_ value: Binding<P>, isFilter: Bool = false) where Destination == P.PropertyView, Cell == PropertyCell {
        self.destination = P.PropertyView(value: value, isFilter: isFilter)
        
        var text = value.wrappedValue.isValid ? value.wrappedValue.valueLabel : "--"
        text = isFilter ? (text == "--" ? "Open to all" : text) : text
        self.cell = PropertyCell(title: P.label, label: text, systemImage: P.systemImage)
        self.title = P.label
        self.svg = P.svgImage
    }
    
    init(_ title: String, svg: String? = nil, systemImage: String, value: String?, isFilter: Bool = false, @ViewBuilder destination: () -> Destination) where Cell == PropertyCell {
        self.destination = destination()
        var text = value ?? "--"
        text = text.isEmpty ? "--" : text
        text = isFilter ? (text == "--" ? "Open to all" : text) : text
        self.title = title
        self.svg = svg
        self.cell = PropertyCell(title: title, label: text, systemImage: systemImage)
    }
}

struct DetailCells_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DetailCell(.constant(alice.gender))
            RangeCell(ageRange: .constant(alice.filters.childrenRange), range: KidAgeRange.range)
            Location.Cell(distance: .constant(alice.filters.maxDistance))
        }
        .listStyle(.grouped)
        .environmentObject(StoreManager())
    }
}
