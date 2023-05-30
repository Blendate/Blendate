//
//  TodayView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var entitlment: StoreManager
    
    let todayUser: User?
    let likedYou: [Swipe]
    @Binding var showLikes: Bool
    
    @State var message: String = ""
    @State var showProfile = false
    
    var body: some View {
        if let todayUser {
            VStack{
                Text("Today's Blend")
                    .font(.largeTitle.weight(.semibold), .white)
                    .padding(.top, 40)
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        VStack {
                            Text(todayUser.firstname)
                                .font(.title2.weight(.bold), .white)
                                .padding(.top, 70)
                            Text("Send a short message and start chating!")
                                .font(.semibold, .white)
                            TextView(text: $message)
                                .frame(width: getRect().width * 0.7, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(16)
                                .padding()
                                .padding(.bottom, 30)
                        }
                        .padding()
                        .background(Color.Blue.opacity(0.5))
                        .cornerRadius(16)
                        Button("Send Message", action: sendTapped)
    //                    .capsuleButton(color: .Blue, fontsize: 18)
                        .offset(y: -25)
                    }.padding(.top, 70)
                    PhotoView(avatar: todayUser.avatar, size: 140)
                        .onTapGesture {
                            showProfile = true
                        }
                }
                ProfileButtonLong(title: "View Likes", systemImage: "star.fill") { showLikes = true }
                    .padding(.horizontal, 32)
                Spacer()
            }
//            .background(bottom: false)
            .sheet(isPresented: $showProfile) {
                ViewProfileView(user: todayUser)
            }

        } else {
            EmptyContentView(text: String.NoProfileFilters) {
                ProfileButtonLong(title: "View Likes", systemImage: "star.fill", color: .Purple) { showLikes = true }
            }
        }
    }
    
    func sendTapped() {
        if entitlment.hasMembership {
            guard let id = todayUser?.id else {return}
            let message = ChatMessage(author: session.uid, text: message)
            Task {
                do {
                    let _ = try await FireStore.shared.swipe(.message, on: id, from: session.uid, message: message)
                    self.showLikes = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            navigation.showPurchaseMembership = true
        }
    }
}

struct TextView: UIViewRepresentable {
 
    @Binding var text: String
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont(name: "Montserrat-Regular", size: 12)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .white
        
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont(name: "Montserrat-Regular", size: 12)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodayView(todayUser: bob, likedYou: likedUser, showLikes: .constant(false))
            TodayView(todayUser: nil, likedYou: likedUser, showLikes: .constant(false))
        }
        .environmentObject(session)
        .environmentObject(StoreManager())
        .environmentObject(NavigationManager())

    }
}
