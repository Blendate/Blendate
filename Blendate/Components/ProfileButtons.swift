//
//  ProfileButtons.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI


struct ProfileButtons: View {
    @EnvironmentObject var sheet: ProfileSheet
    let profileType: ProfileType
    var action: (_ swipe: Swipe) -> Void


    init(_ profileType: ProfileType, didSwipe: @escaping ((_ swipe: Swipe) -> Void)){
        self.profileType = profileType
        self.action = didSwipe
    }
//    
//    init(_ profileType: ProfileType){
//        self.profileType = profileType
//        self.action = Swipe.like -> ()
//    }
    
    var body: some View {
        switch profileType {
        case .session:
            profileButtons
        case .match:
            matchButtons
        case .view:
            noButtons
        }
    }
}

extension ProfileButtons {
    
    var profileButtons: some View {
        HStack {
            ProfileButton(type: .edit, state: $sheet.state)
            SeperatorView(2)
                .frame(height: 50)
                .opacity(0.5)
            ProfileButton(type: .filter, state: $sheet.state)
            SeperatorView(2)
                .frame(height: 50)
                .opacity(0.5)
            ProfileButton(type: .settings, state: $sheet.state)
        }
        .accentColor(.white)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    var matchButtons: some View {
        HStack {
            Spacer()
            BlendButton(swipe: .pass, action: action)
            Spacer()
            BlendButton(swipe: .like, action: action)
            Spacer()
        }.padding([.bottom, .horizontal])
    }
    
    var noButtons: some View {
        HStack{
            Spacer()
        }.padding(.bottom)
    }
}

extension ProfileButtons {
    struct ProfileButton: View {
        
        let type: ProfileSheet.State
        @Binding var state: ProfileSheet.State?

        var body: some View {
            Button(action:{
                printD(type.rawValue)
                state = type
                printD(state?.rawValue ?? "NONE")

                
            }){
                VStack(alignment: .center){
                    Text(type.rawValue)
                    if type == .edit {
                        Image(systemName: "person")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding(.bottom, 10)
                    } else {
                        Image(type.image)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding(.bottom, 10)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)

        }
    }
    
    struct BlendButton: View {
        
        let swipe: Swipe
        var action: (_ swipe: Swipe) -> Void

        var body: some View {
            let blend = swipe == .like
            let color:Color = blend ? .Blue:.red
            Button(action: swiped) {
                Image(blend ? "icon":"noMatch")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(color)
                    .frame(width: blend ? 30:40, height: 40)
                    .padding(blend ? 20:15)
                    .background(Color.white)
                    .clipShape(Circle())
            }
        }
        
        private func swiped(){
            action(swipe)
        }
    }
}


struct ProfileButtons_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtons(.match) { swipe in
            
        }
        
    }
}


//                ZStack{
//                    Capsule()
//                        .fill(Color.white)
//                        .frame(width: 160, height: 60, alignment: .center)
//                    HStack {
//                        Image(blend ? "icon":"noMatch")
//                            .renderingMode(.template)
//                            .resizable()
//                            .foregroundColor(color)
//                            .frame(width: blend ? 30:40, height: 40)
//                        Text(blend ? "BLEND":"NEXT")
//                            .fontType(.regular, 16, color)
//                    }
//                }