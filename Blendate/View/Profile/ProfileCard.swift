//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI
enum ProfileType {
    case myProfile
    case dateProfile
//    case editProfile
}

struct ProfileCardView: View {
    @EnvironmentObject var session: Session
    
    @Binding var user: User
//    @Binding var selected: Int
    var type: ProfileType
    @Binding var editTapped:Bool

    var body: some View {
        VStack {
            VStack {
                topRow
                name
                if !editTapped {
                    switch type {
                        case .myProfile: myProfile
                        case .dateProfile: dateProfile.padding(.top)
                    }
                } else {
                    
                }

            }
            .padding(.bottom)
            .background(Color.BlueAlpha)
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
            if editTapped {
                Button(action: {editTapped = false}, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.Blue)
                        .clipShape(Capsule())
                })
            } else {
                Spacer()
                switch type {
                case .myProfile:
                    Button(action: {editTapped = true}, label: {
                        Image("pencil")
                            .foregroundColor(.white)
                            .circle()
                    })
                    
                case .dateProfile:
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "ellipsis")//.rotationEffect(.degrees(90))
                            .foregroundColor(.white)
                            .circle()
                    })
                    
                }
            }
        }.padding([.horizontal, .top], 20)
    }
    
    var name: some View {
        VStack {
            if editTapped {
                Text("Edit Profile")
                    .blendFont(24, .white)
                            } else {
                Text(user.fullName() + ", \(user.age())").bold()
                Text(user.location)
            }
        }.foregroundColor(.white)
        .padding(.bottom, 5)
    }
    
    var dateProfile: some View {
        HStack {
            Button(action: dislike, label: {
                ZStack{
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 160, height: 60, alignment: .center)
                    HStack {
                        Image("noMatch")
                            .resizable()
                            .foregroundColor(.Blue)
                            .frame(width: 40, height: 40)
                        Text("Next")
                            .blendFont(28)
                    }
                }
            }).padding(.trailing)
            
            Button(action: like, label: {
                ZStack{
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 160, height: 60, alignment: .center)
                    HStack {
                        Image("icon")
                            .resizable()
                            .foregroundColor(.Blue)
                            .frame(width: 40, height: 40)
                        Text("Blend")
                            .blendFont(28)
                    }
                }
            })

        }.padding(.bottom)
    }
    
    var editProfile: some View {
        HStack {
            
        }
    }
    
    var myProfile: some View {
        HStack {
            Spacer()
            NavigationLink(
                destination: PreferencesView(user: $user),
                label: {
                    VStack{
                        Text("Help Center")
                            .font(.custom("LexendDeca-Regular.", size: 14))
                        Image(systemName: "info.circle")
                            .font(.system(size: 26))
                            .padding(5)
                    }
                })
            Spacer()
            NavigationLink(
                destination: SettingsView(),
                label: {
                    VStack{
                        Text("Settings")
                            .font(.custom("LexendDeca-Regular.", size: 14))
                        Image("settings")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding(5)
                    }
                })
            Spacer()
            NavigationLink(
                destination: PreferencesView(user: $user),
                label: {
                    
                        VStack{
                            Text("Preferences")
                                .font(.custom("LexendDeca-Regular.", size: 14))
                            Image("Filter")
                                .resizable()
                                .frame(width: 26, height: 26)
                                .font(.system(size: 26))
                                .padding(5)
                        }
                })
            Spacer()
        }.accentColor(.white)
    }
    
    func dislike(){
        self.user = Dummy.user2
    }
    
    func like(){
        
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
            .fill(color)
            .frame(width: CGFloat(size))
    }
}

#if DEBUG
struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardView(user: .constant(Dummy.user), type: .myProfile, editTapped: .constant(false))
        ProfileCardView(user: .constant(Dummy.user), type: .dateProfile, editTapped: .constant(false))
    }
}
#endif
