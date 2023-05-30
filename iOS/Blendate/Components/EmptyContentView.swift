//
//  EmptyContentView.swift
//  Blendate
//
//  Created by Michael on 5/30/23.
//

import SwiftUI

struct EmptyContentView<Button: View, Button2: View>: View {
    
    var text: String
    var svg: String
    
    @ViewBuilder var button: Button
    @ViewBuilder var button2: Button2
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16){
                Spacer()
                Text(text)
                    .font(.title2.weight(.semibold), .Blue)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical,32)
                    .padding(.top, 32)
                Spacer()
                button
                    .padding(.horizontal, 32)
                button2
                    .padding(.horizontal, 32)
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.5)
        }
        .background(svg: svg, bottom: false)
    }
}

extension EmptyContentView {
    init(text: String, svg: String? = nil) where Button == FilterButton, Button2 == EmptyView {
        self.text = text
        self.svg = svg ?? "Family"
        self.button = FilterButton()
        self.button2 = EmptyView()
    }
    
    init(text: String, svg: String? = nil,
         @ViewBuilder button: () -> Button2) where Button == FilterButton {
        self.text = text
        self.svg = svg ?? "Family"
        self.button = FilterButton()
        self.button2 = button()
    }
}

struct EmptyContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyContentView(text: "There are no more profiles with your current filters, change some filters to see more profiles")
    }
}
