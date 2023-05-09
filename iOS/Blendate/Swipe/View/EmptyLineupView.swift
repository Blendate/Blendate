//
//  EmptyLineupView.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

struct EmptyLineupView<Button1:View, Button2: View>: View {
    
    @Binding var loading: Bool
    var svg: String = "Family"
    var text: String = "There are no more profiles with your current filters, change some filters to see more profiles"
    
    @ViewBuilder var button1: Button1
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
//                Spacer()
                button1
                button2
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.5)
        }
        .background(svg: svg, bottom: false)
    }
}

extension EmptyLineupView {
    init(
        loading: Binding<Bool> = .constant(false),
        text: String? = nil,
        button: Button1) where Button2 == EmptyView
    {
        self._loading = loading
        self.button1 = button
        self.button2 = EmptyView()
        if let text { self.text = text }
    }
    
    init(
        loading: Binding<Bool>,
        @ViewBuilder button: () -> Button1) where Button2 == EmptyView
    {
        self._loading = loading
        self.button1 = button()
        self.button2 = EmptyView()
    }
}

struct EmptyLineupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyLineupView(loading: .constant(true)) {
                ProfileButtonLong(title: "Filters", systemImage: "slider.horizontal.3" ) {}
                    .padding(.horizontal, 32)
            } button2: {
                ProfileButtonLong(title: "View Likes", systemImage: "star.fill", color: .Purple) {}
                    .padding(.horizontal, 32)
            }
        }
    }
}


