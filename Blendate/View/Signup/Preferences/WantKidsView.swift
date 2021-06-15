//
//  WantKidsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct WantKidsView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Want kids?")
            HStack {
                NextButton(title: "Yes") {
                    session.user.familyPlans = .wantMore
                    next.toggle()
                }
                NextButton(title: "No") {
                    session.user.familyPlans = .dontWant
                    next.toggle()
                }
            }
            NextButton(title: "No Preference") {
                session.user.familyPlans = .dontCare
                next.toggle()
            }
            if signup {
                NavigationLink(
                    destination: AddPhotosView(true),
                    isActive: $next,
                    label: {Text("")}
                )
            }
            
        }
    }
}
