//
//  TodayView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var match: MatchesViewModel
    @EnvironmentObject var swipe: SwipeViewModel

    let todayUser: User
    @Binding var showLikes: Bool

    @State var message: String = ""
    @State var showProfile = false
    
    var body: some View {
        VStack{
            Text("Today's Blend")
                .fontType(.semibold, 42, .white)
                .padding(.top, 40)
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    VStack {
                        Text(todayUser.fullName)
                            .fontType(.bold, 24, .white)
                            .padding(.top, 70)
                        Text("Send a short message and start chating!")
                            .fontType(.semibold, 14, .white)
                        TextView(text: $message)
                            .frame(width: getRect().width * 0.7, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(16)
                            .padding()
                            .padding(.bottom, 30)
                    }
                    .padding()
                    .background(Color.Blue.opacity(0.5))
                    .cornerRadius(16)
                    AsyncButton("Send Message", action: sendMessage)
                    .capsuleButton(color: .Blue, fontsize: 18)
                    .offset(y: -25)
                }.padding(.top, 70)
                PhotoView.Avatar(url: todayUser.avatar, size: 140)
                    .onTapGesture {
                        showProfile = true
                    }
            }
            Button("View Likes"){
                showLikes = true
            }
            .foregroundColor(.white)
            .capsuleButton(color: .DarkPink, fontsize: 18)
            Spacer()
        }
        .background(bottom: false)
        .sheet(isPresented: $showProfile) {
            ViewProfileView(details: todayUser)
        }
    }
    
    func sendMessage() async {
        if settings.hasPremium {
            guard let id = todayUser.id else {return}
            do {
                let _ = await swipe.swipe(on: id, .superLike)
                let message = ChatMessage(author: settings.uid, text: message)
                let match = try self.match.create(with: id, message: message)
                showLikes = true
            } catch {
                print(error.localizedDescription)
            }
        } else {
            settings.showMembership = true
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
        TodayView(todayUser: dev.tyler, showLikes: .constant(false))
    }
}
