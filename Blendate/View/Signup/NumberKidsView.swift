//
//  NumbersView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct NumberKidsView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    var kidsProxy: Binding<Double> {
        Binding<Double>(
            get: { Double(session.user.children) },
            set: { session.user.children = Int($0) }
        )
    }
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Number of Kids")
            Slider(value: kidsProxy, in: 0...12, step: 1)
            if signup {
                NavigationLink(
                    destination: KidsRangeView(true),
                    isActive: $next,
                    label: {Text("Next")}
                )
            }
            
        }
    }
}
