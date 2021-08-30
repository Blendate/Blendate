////
////  MyTabView.swift
////  Blendate
////
////  Created by Michael on 8/6/21.
////
//
//import Foundation
//import SwiftUI
//
//struct MyTabView: View {
//    #warning("all icons are not same square size")
//    
//    @EnvironmentObject var session: Session
//    @Binding var selectedTab:Int
//    @Binding var user: AppUser
//    
//    let iconSize: Int = 25
//    
//    var body: some View {
//        ZStack {
//            switch selectedTab {
//            case 0:
//                ProfileView(.dateProfile)
//            case 1:
//                ChatRoomView($session.user)
//            case 2:
//                TodayBlendView(user: Dummy.user)
//            case 3:
//                ProfileView()
//            default: Text("4")
//            }
//            VStack {
//                Spacer()
//                HStack {
//                    Button(action: {selectedTab = 0}, label: {
//                        Image("icon-2")
//                            .foregroundColor(selectedTab == 0 ? .DarkPink:.Blue)
//                            .padding(10)
//                            .padding(.horizontal)
//                            .background(selectedTab == 0 ? Color.LightPink:Color.clear)
//                            .clipShape(Capsule())
//                    })
//                    Spacer()
//                    Button(action: {selectedTab = 1}, label: {
//                        Image("chat")
//                            .foregroundColor(selectedTab == 1 ? .DarkPink:.Blue)
//                            .padding(10)
//                            .padding(.horizontal)
//                            .background(selectedTab == 1 ? Color.LightPink:Color.clear)
//                            .clipShape(Capsule())
//                    })
//                    Spacer()
//                    Button(action: {selectedTab = 2}, label: {
//                        Image("heart")
//                            .foregroundColor(selectedTab == 2 ? .DarkPink:.Blue)
//                            .padding(10)
//                            .padding(.horizontal)
//                            .background(selectedTab == 2 ? Color.LightPink:Color.clear)
//                            .clipShape(Capsule())
//                    })
//                    Spacer()
//                    Button(action: {selectedTab = 3}, label: {
//                        Image("profile")
//                            .foregroundColor(selectedTab == 3 ? .DarkPink:.Blue)
//                            .padding(10)
//                            .padding(.horizontal)
//                            .background(selectedTab == 3 ? Color.LightPink:Color.clear)
//                            .clipShape(Capsule())
//                    })
//                }
//                .padding()
//                .background(Color.white)
//                .clipShape(Capsule())
//                .shadow(radius: 2)
//                .frame(width: getRect().width)
//
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        }
//        
//    }
//}
//
//struct LoadingView: View {
//    @EnvironmentObject var session: Session
//    @State private var isLoading = false
// 
//    var body: some View {
//        VStack {
//            ZStack {
//                
//                Circle()
//                    .stroke(Color(.systemGray5), lineWidth: 14)
//                    .frame(width: 100, height: 100)
//     
//                Circle()
//                    .trim(from: 0, to: 0.2)
//                    .stroke(Color.green, lineWidth: 7)
//                    .frame(width: 100, height: 100)
//                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
//                    .onAppear() {
//                        self.isLoading = true
//                }
//            }
//            Button("LOGOUT") {
//                session.logout()
//            }
//        }
//    }
//}
