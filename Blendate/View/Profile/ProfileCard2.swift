////
////  ProfileCard2.swift
////  Blendate
////
////  Created by Michael on 6/1/21.
////
//
//import SwiftUI
//
//struct ProfileCard2: View {
//    @Binding var user: User
//    let type: ProfileType
//    
//    init(_ user: Binding<User>, _ type: ProfileType = .myProfile){
//        self.type = type
//        self._user = user
//    }
//    
//    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color(UIColor(red: 0.345, green: 0.396, blue: 0.965, alpha: 0.6)))
//                .frame(height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .padding()
//            
//            FirebaseImageView(imageURL: user.profileImage)
//                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                .frame(width: 92, height: 92, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .offset(x: 0, y: -90.0)
//            
//            
//            VStack {
//                HStack {
//                    Spacer()
//                    Image(systemName: "pencil.circle.fill")
//                        .resizable()
//                        .foregroundColor(.white)
//                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                }
//                .padding(.horizontal, 30)
//                
//                Text(user.fullName() + ", \(user.age())")
//                    .font(.custom("LexendDeca-Regular.", size: 18))
//                    .foregroundColor(.white)
//                    .bold()
//                Text("\(user.location), USA")
//                    .font(.custom("LexendDeca-Regular.", size: 14))
//                    .foregroundColor(.gray)
//                HStack {
//                    Spacer()
//                    ProfileButtonView(title: "Help Center", icon: "Info", action: {
//                        print("**** HElP ****")
//                    })
//                    .padding()
//                    
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(width: 1, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    Spacer()
//                    NavigationLink(
//                        destination: SettingsView(),
//                        label: {
//                            ProfileButtonView2(title: "Settings", icon: "settings")
//                            
//                        }).padding()
//                    
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(width: 1, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    Spacer()
//                    ProfileButtonView(title: "Preference", icon: "Filter", action: {
//                        print("**** PREFERENCE ****")
//                    })
//                    Spacer()
//                }
//                //                myProfile
//                //                .padding(.horizontal, 30)
//                //                .padding(.bottom)
//            }
//            .padding(.top, 30)
//        }
//    }
//    
//    var myProfile: some View {
//        HStack {
//            Button(action: {}, label: {
//                VStack{
//                    Text("Help Center")
//                        .font(.custom("LexendDeca-Regular.", size: 14))
//                    
//                    Image(systemName: "info.circle")
//                        .font(.system(size: 26))
//                        .padding(5)
//                }
//            }).padding(.trailing)
//            Rectangle()
//                .fill(Color.white)
//                .frame(width: 1, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            NavigationLink(
//                destination: SettingsView(),
//                label: {
//                    VStack{
//                        Text("Settings")
//                            .font(.custom("LexendDeca-Regular.", size: 14))
//                        
//                        Image("settings")
//                            .resizable()
//                            .foregroundColor(.white)
//                            .frame(width: 30, height: 30)
//                            .padding(5)
//                    }
//                }).padding(.horizontal)
//            NavigationLink(
//                destination: PreferencesView(),
//                label: {
//                    
//                    VStack{
//                        Text("Preferences")
//                            .font(.custom("LexendDeca-Regular.", size: 14))
//                        Image(systemName: "slider.horizontal.3")
//                            .font(.system(size: 26))
//                            .padding(5)
//                    }
//                }).padding(.horizontal)
//        }.accentColor(.white)
//    }
//}
//
//struct ProfileButtonView: View {
//    var title : String
//    var icon : String
//    var action : () -> Void
//    
//    var body: some View {
//        Button(action: action, label: {
//            VStack {
//                Text(title)
//                    .foregroundColor(.white)
//                    .font(.custom("LexendDeca-Regular.", size: 14))
//                Image(icon)
//            }
//        })
//    }
//}
//
//struct ProfileButtonView2: View {
//    var title : String
//    var icon : String
//    
//    var body: some View {
//        VStack {
//            Text(title)
//                .foregroundColor(.white)
//                .font(.custom("LexendDeca-Regular.", size: 14))
//            Image(icon)
//        }
//    }
//}
//
//struct ProfileCard2_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCard2(.constant(Dummy.user))
//            .previewDevice("iPhone 8")
//        
//        ProfileCard2(.constant(Dummy.user))
//            .previewDevice("iPhone 11")
//    }
//}
