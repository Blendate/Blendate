//
//  InterestedView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct InterestedView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                HStack {
                    Button("Friendship", action: {
                        session.user.gender = .male
                        next.toggle()
                    })
                    Button("Relationship", action: {
                        session.user.gender = .female
                        next.toggle()
                    })
                }
                Button("Both", action: {
                    session.user.gender = .nonBinary
                    next.toggle()
                })
                if signup {
                    NavigationLink(
                        destination: LocationView(true),
                        isActive: $next,
                        label: {
                            Text("")
                        })
                }

            }
    }
}
