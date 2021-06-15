//
//  NextButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI



struct NextButton: View {
    
    @Binding var isActive: Bool
    var title: String = "Next"
    var color: Color = Color.Blue
    var action: ()->Void
    
    var body: some View {
        Button(action:{
            if isActive {
                action()
            }}){
            HStack {
                Spacer()
                Text(title)
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(isActive ? .white:.black)
                    .padding()
                Spacer()
                
            }.background(isActive ? color:.gray)
            .clipShape(Capsule())
        }
    }
}

struct SignupNext<Content: View>: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let title: String = "Next"
    let color: Color = Color.Blue
    
    @Binding var active: Bool
    let destination: Content
    let signup: Bool
    
    init(_ signup: Bool,
        _ active: Binding<Bool>,
        _ destination: Content){
        self._active = active
        self.destination = destination
        self.signup = signup
    }
    
    
    var body: some View {
        
        if signup {
            NavigationLink(
                destination: destination,
                label: {
                        
                        Text(title)
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(active ? .DarkBlue:.gray)
                        
//                        HStack {
//                            Spacer()
//                            Text(title)
//                                .bold()
//                                .font(.system(size: 20))
//                                .foregroundColor(active ? .white:.black)
//                                .padding()
//                            Spacer()
//                        }.background(active ? color:.gray)
//                        .clipShape(Capsule())
                }).disabled(!active)
        } else {
            Text("")
        }
    }
}

struct ItemButton: View {
    
    var title: String = "Blendate"
    var active: Bool
    var action: ()->Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.system(size: 18))
                //                .padding(.vertical, 5)
                //                .padding(.horizontal)
                .padding()
                .foregroundColor(active ? .white:.Blue)
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
        }
    }
}
