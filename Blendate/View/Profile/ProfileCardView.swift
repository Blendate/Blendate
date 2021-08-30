//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI
import RealmSwift


struct ProfileCardView: View {
//    @EnvironmentObject var state: AppState

    var type: ProfileType
//    @Binding var editTapped:Bool
    @Binding var editType: EditType
    @Binding var sheetState: SheetState

    
    @Binding var userPref: UserPreferences?
    var pass: ()->Void
    var blend: ()->Void


    let photoSize:CGFloat = 100

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                topRow
                name
                if editType == .none {
                    buttonRow
                } else {
                    Divider()
                    editRow
                }
            }
            .background(Color.BlueAlpha)
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, photoSize/2)
            profileImage
                
        }
//        .offset(y: UIScreen.main.bounds.height * 0.35 - 175)
        .padding(.horizontal)
    }
    
    var profileImage: some View {
        VStack {
            if let photo = userPref?.profilePhoto {
                PhotoView(photo: .constant(photo), large: true)
                    .frame(width: photoSize, height: photoSize).clipShape(Circle())
            } else {
                Circle()
                    .frame(width: photoSize, height: photoSize)
                    .foregroundColor(.red)
            }
        }
    }
    
    
    var buttonRow: some View {
        Group {
            switch type {
                case .myProfile: myProfile
                case .dateProfile: dateProfile
            }
        }.padding(.bottom, 10)
    }
    
    var editRow: some View {
        HStack {
            Button(action: {editType = .About} ){
                Text("About")
                    .foregroundColor(editType.rawValue == "About" ? .yellow:.white)
            }
            Spacer()
            Button(action: {editType = .Photos} ){
                Text("Photos")
                    .foregroundColor(editType.rawValue == "Photos" ? .yellow:.white)
            }
            Spacer()
            Button(action: {editType = .Interests} ){
                Text("Interests")
                    .foregroundColor(editType.rawValue == "Interests" ? .yellow:.white)
            }
        }
        .padding()
        .padding(.horizontal)
    }
    

    var topRow: some View {
        HStack {
            if editType != .none {
                Button(action: {editType = .none}, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
                Spacer()
                Spacer()
            }
        }.padding([.horizontal, .top], 20)
    }
    
    var name: some View {
        VStack {
            if editType != .none {
                Text("Edit Profile")
                    .lexendDeca(.regular, 24)
//                    .blendFont(24, .white)
            } else {
                Text(userPref?.fullName() ?? "")// + ", \(user.age())").bold()
                Text(userPref?.location ?? "")
                Text(userPref?.ageString() ?? "")

            }
        }.foregroundColor(.white)
        .padding(.bottom, 5)
        .padding(.top, photoSize/3)
    }
    
    var dateProfile: some View {
        HStack {
            BlendButton(blend: false, action: pass).padding(.trailing)
            BlendButton(blend: true, action: {})
        }.padding(.vertical)
    }
    
    
    var myProfile: some View {
        HStack {
            Button(action: {editType = .About}, label: {
                VStack{
                    Text("Edit Profile")
                        .font(.custom("LexendDeca-Regular.", size: 14))
                    Image("pencil")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding(.vertical, 5)
                        .offset(y: -3)
                }
            }).padding(.leading)
            Spacer()
            Button(action: {sheetState = .preferences}, label: {
                VStack{
                    Text("Preferences")
                        .font(.custom("LexendDeca-Regular.", size: 14))
                    Image("Filter")
                        .resizable()
                        .frame(width: 30, height: 30)
//                                .font(.system(size: 26))
                        .padding(.vertical, 5)
                }
            })
            .offset(x: -7)
//            NavigationLink(
//                destination: PreferencesView(),
//                label: {
//
//                        VStack{
//                            Text("Preferences")
//                                .font(.custom("LexendDeca-Regular.", size: 14))
//                            Image("Filter")
//                                .resizable()
//                                .frame(width: 30, height: 30)
////                                .font(.system(size: 26))
//                                .padding(.vertical, 5)
//                        }
//                })
//                .offset(x: -7)
            Spacer()
            Button(action: {sheetState = .account}, label: {
                VStack{
                    Text("Settings")
                        .font(.custom("LexendDeca-Regular.", size: 14))
                    Image("settings")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .padding(.vertical, 5)
                }
            }).padding(.trailing)
//            NavigationLink(
//                destination: AccountView(),
//                label: {
//                    VStack{
//                        Text("Settings")
//                            .font(.custom("LexendDeca-Regular.", size: 14))
//                        Image("settings")
//                            .resizable()
//                            .foregroundColor(.white)
//                            .frame(width: 30, height: 30)
//                            .padding(.vertical, 5)
//                    }
//                }).padding(.trailing)
        }.accentColor(.white)
        .padding(.horizontal)
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

enum ProfileType {
    case myProfile
    case dateProfile
}

enum EditType: String {
    case none
    case About
    case Photos
    case Interests
}
enum SheetState {
    case none
    case account
    case preferences
}


struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {

        ScrollView {
            ProfileCardView(type: .myProfile, editType: .constant(.About), sheetState: .constant(.none), userPref: .constant(Dummy.userPref), pass:{}, blend: {})
            ProfileCardView(type: .myProfile, editType: .constant(.About), sheetState: .constant(.none), userPref: .constant(Dummy.userPref), pass:{}, blend: {})
            ProfileCardView(type: .dateProfile, editType: .constant(.About), sheetState: .constant(.none), userPref: .constant(Dummy.userPref), pass:{}, blend: {})
            Spacer()
        }

    }
}
