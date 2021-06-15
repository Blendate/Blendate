//
//  HeightView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct HeightView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                HeightSlider(
                    height: $user.height,
                    sliderHeight: geo.size.height
                )
            }
            Text(String(user.height))
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavigationLink(
                                    destination: InterestedView(signup, $user),
                                    isActive: $next,
                                    label: {
                                        NextButton(next: $next, isTop: true)
                                    }
                                ))//.disabled(session.user.gender == .none))
        .circleBackground(imageName: "Height", isTop: true)
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
            HeightView(true, .constant(Dummy.user))
        }
    }
}
#endif
