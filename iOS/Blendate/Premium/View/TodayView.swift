//
//  TodayView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var entitlment: EntitlementManager
    
    let todayUser: User?
    let likedYou: [Swipe]
    @Binding var showMembership: Bool
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
                            Text(todayUser.details.firstname)
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
                    PhotoView(avatar: todayUser.details.avatar, size: 140)
                        .onTapGesture {
                            showProfile = true
                        }
                }
                Button("View Likes"){
                    showLikes = true
                }
                .foregroundColor(.white)
                .shapeButton(shape: .roundedRectangle, color: .Purple)
                Spacer()
            }
//            .background(bottom: false)
            .sheet(isPresented: $showProfile) {
                ViewProfileView(user: todayUser)
            }
        } else {
            EmptyLineupView(loading: .constant(false)) {
                FilterButton(user: $session.user, settings: $session.settings)
            } button2: {
                Button("View Likes"){ showLikes = true }
                    .shapeButton(shape: .roundedRectangle, color: .Purple)

            }
        }
    }
    
    func sendTapped() {
        if entitlment.hasPro {
            guard let id = todayUser?.id else {return}
            let message = ChatMessage(author: session.uid, text: message)
            Task {
                do {
                    let _ = try await FireStore.instance.swipe(.message, on: id, from: session.uid, message: message)
                    self.showLikes = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            showMembership = true
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
        TodayView(todayUser: bob, likedYou: likedUser, showMembership: .constant(false), showLikes: .constant(false))
    }
}
