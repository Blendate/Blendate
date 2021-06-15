//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var kids = false
    @State private var location = false

    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Parent")
            HStack {
                NavigationLink(
                    destination: NumberKidsView(true),
                    isActive: $kids,
                    label: {
                        NextButton(title: "Yes") {
                            session.user.isParent = true
                            kids.toggle()
                        }
                    }
                )
                
                NavigationLink(
                    destination: LocationView(true),
                    isActive: $location,
                    label: {
                        NextButton(title: "No") {
                            session.user.isParent = false
                            location.toggle()
                        }
                    }
                )
                
            }
        }
    }
}
