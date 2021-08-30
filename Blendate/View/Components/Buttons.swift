//
//  NextButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct BlendButton: View {
    let blend: Bool
    var action: ()->Void

    var body: some View {
        Button(action: action, label: {
            ZStack{
                Capsule()
                    .fill(Color.white)
                    .frame(width: 160, height: 60, alignment: .center)
                HStack {
                    Image(blend ? "icon":"noMatch")
                        .resizable()
                        .foregroundColor(.Blue)
                        .frame(width: blend ? 30:40, height: 40)
                    Text(blend ? "BLEND":"NEXT")
                        .font(.custom("LexendDeca-Regular", size: 17))
                        .foregroundColor(.Blue)
                }
            }
        })
    }
}

struct CapsuleButton: View {

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

struct BackButton: View {

    let signup: Bool
    let isTop: Bool
    var action: ()->Void

    var body: some View {
        Button(action: action) {
            Image(systemName: signup ? "chevron.left":"xmark")
                .padding([.vertical, .trailing])
                .foregroundColor(isTop ? .white:.DarkBlue)
        }
    }
}

struct NextButton: View {

    @Binding var next: Bool
    var isTop: Bool

    var body: some View {
        Text("Next")
            .font(.custom("Montserrat-Bold", size: 16))
            .foregroundColor(isTop ? .white:.DarkBlue)
    }
}


struct NavNextButton: View {
    let signup: Bool
    let isTop: Bool
    var action: ()->Void
    
    init(_ signup: Bool, _ isTop: Bool, _ action: @escaping()->Void){
        self.signup = signup
        self.isTop = isTop
        self.action = action
    }
    
    var body: some View {
        
        Button(action: action){
            Text(signup ? "Next":"Save")
                .font(.custom("Montserrat-Bold", size: 16))
                .foregroundColor(isTop ? .white:.DarkBlue)
        }
    }
}



struct ItemButton: View {
    
    var title: String = "Blendate"
    var width: CGFloat = 136
    var active: Bool = false
    var action: ()->Void
    
    var body: some View {

        
        Button(action: action, label: {
            ZStack{
                Capsule()
                    .fill(active ? Color.Blue:Color.white)
                    .frame(width: width, height: 45, alignment: .center)
                Text(title)
                    .font(.custom("Montserrat-Regular", size: 18))
                    .foregroundColor(active ? .white:.Blue)
            }
        })
    }
}
