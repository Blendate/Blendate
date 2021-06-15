//
//  HeightView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct HeightView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            GeometryReader { geo in
                HeightSlider(
                    height: $session.user.height,
                    sliderHeight: geo.size.height
                )
            }
            Text(String(session.user.height))
            if signup {
                NavigationLink(
                    destination: ParentView(true),
                    isActive: $next,
                    label: {
                        NextButton(action: {next.toggle()})
                    })
            }
        }
    }
}


struct HeightSlider: View {
    @Binding var height: Double
    var sliderHeight:CGFloat

    var body: some View {
        Slider(value: $height, in: 120...250, step: 1)
        .rotationEffect(.degrees(-90.0), anchor: .topLeading)
//        .frame(width: sliderHeight)
//        .offset(y: sliderHeight)
    }
}

#if DEBUG
struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeightView(true)
                .environmentObject(Session())
        }
    }
}
#endif
