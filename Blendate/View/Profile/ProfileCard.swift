//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct ProfileCardView: View {
    @Binding var user: User
//    @Binding var selected: Int
    var type: ProfileType

    var body: some View {
        VStack {
            VStack {
                topRow
                name
                switch type {
                    case .myProfile: myProfile
                    case .dateProfile: dateProfile
                    case .editProfile: editProfile
                }
            }
            .padding(.bottom)
            .background(Color.Blue)
            .mask(RoundedRectangle(cornerRadius: 25.0))
            profileImage
        }
    }
    
    var profileImage: some View {
//        VStack {
        FirebaseImageView(imageURL: user.profileImage)
            .clipShape(Circle())
//            Circle()
//                .foregroundColor(.green)
                .frame(width: 100, height: 100)
                .offset(y: -265)
    }
    
    var topRow: some View {
        HStack{
            if type == .editProfile {
                Button(action: {}, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
            }
            Spacer()
            Button(action: {}){
                switch type {
                case .myProfile:
                    Image("pencil")
                        .foregroundColor(.white)
                        .circle()
                case .dateProfile:
                    Image(systemName: "ellipsis")//.rotationEffect(.degrees(90))
                        .foregroundColor(.white)
                        .circle()
                case .editProfile:
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.Blue)
                        .clipShape(Capsule())
                }

            }
        }.padding([.horizontal, .top], 20)
    }
    
    var name: some View {
        VStack {
            if type != .editProfile {
                Text(user.fullName() + ", \(user.age())").bold()
                Text(user.location)
            } else {
                Text("Edit Profile")
                    .blendFont(24, .white)
            }
        }.foregroundColor(.white)
        .padding(.bottom, 5)
    }
    
    var dateProfile: some View {
        HStack {
            Button(action:{}){
                HStack {
                    Image("noMatch")
                        .foregroundColor(.red)
                    Text("DISMISS")
                        .foregroundColor(.red)
                }.padding()
                .background(Color.white)
                .clipShape(Capsule())
            }
            Button(action:{}){
                HStack {
                    Image("icon")
                        .foregroundColor(Color.Pink)
                    Text("BLEND")
                        .foregroundColor(Color.Pink)
                }.padding()
                .background(Color.white)
                .clipShape(Capsule())
            }
        }.padding(.bottom)
    }
    
    var editProfile: some View {
        HStack {
            
        }
    }
    
    var myProfile: some View {
        HStack {
            Button(action: {}, label: {
                VStack{
                    Text("Help Center")
                    Image(systemName: "info.circle")
                        .font(.system(size: 26))
                        .padding(5)
                }
            }).padding(.trailing)
            NavigationLink(
                destination: SettingsView(),
                label: {
                    VStack{
                        Text("Settings")
                        Image("settings")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding(5)
                    }
                }).padding(.horizontal)
            NavigationLink(
                destination: PreferencesView(),
                label: {
                    
                        VStack{
                            Text("Preferences")
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 26))
                                .padding(5)
                        }
                }).padding(.horizontal)
        }.accentColor(.white)
    }
}


struct Seperator: View {
    
    let size:Int
    let color: Color
    
    init(_ size: Int = 1, _ color: Color = Color.white){
        self.size = size
        self.color = color
    }
    
    var body: some View {
        Rectangle()
            .frame(width: CGFloat(size))
            .foregroundColor(color)
    }
}

#if DEBUG
struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardView(user: .constant(Dummy.user), type: .myProfile)
        ProfileCardView(user: .constant(Dummy.user), type: .dateProfile)
        ProfileCardView(user: .constant(Dummy.user), type: .editProfile)

    }
}
#endif
