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

    var body: some View {
        switch profileType {
        case .session:
            noButtons
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
            BlendButton(swipe: .superLike, action: action)
                .padding(.top)
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
                state = type
            }){
                VStack(alignment: .center){
                    Text(type.rawValue)
                    if type == .edit {
                        Image(systemName: "pencil")
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

        var blend: Bool {
            swipe == .like
        }
        var body: some View {
            Button(action: swiped) {
                Group {
                    if swipe == .superLike {
                        Image(systemName: "star.fill")
                            .renderingMode(.template)
                            .resizable()

                    } else {
                        Image(swipe.imageName)
                            .renderingMode(.template)
                            .resizable()
                    }

                }
                .foregroundColor(.white)
                .frame(width: blend ? 20:30, height: 30)
                .padding(blend ? 15:10)
                .background(swipe.color)
                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                    .stroke(Color.white, lineWidth: 1)
//                )
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


