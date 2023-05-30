//
//  PropertyView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

struct PropertyView<Content:View>: View {
    let title: String?
    let svg: String?
    @ViewBuilder var content: Content

    var body: some View {
        VStack {
            if let title {
                Text(title)
                    .font(.title.weight(.semibold), .DarkBlue)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                    .padding(.horizontal)
            }
            content
            Spacer()
        }
        .background(svg: svg)
    }
    
//    init(path: Onboarding, signup: Bool = false, isFilter: Bool = false, @ViewBuilder content: () -> Content) {
//        self.title = path.title
//        self.svg = path.svg
//        self.signup = signup
//        self.isFilter = isFilter
//        self.content = content()
//    }
    
    init(title: String?, svg: String?, @ViewBuilder content: () -> Content) {
        self.title = title
        self.svg = svg
        self.content = content()
    }
    
    init<P:Property>(_ type: P.Type, view: P.PropertyView) where Content == P.PropertyView {
        self.title = type.title
        self.svg = type.svgImage
        self.content = view
    }
}



struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView(title: Onboarding.gender.title, svg: Onboarding.gender.svg) {
            Gender.PropertyView(value: .constant(.female))
        }
    }
}
