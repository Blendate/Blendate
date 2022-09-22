//
//  TodayView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct TodayView: View {
    @State var todayUser: User = DeveloperPreview.instance.tyler
    @State var message: String = ""
    @State var showProfile = false
    
    var body: some View {
        VStack{
            Text("Today's Blend")
                .fontType(.semibold, 42, .Blue)
                .padding(.top, 40)
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    VStack {
                        Text(todayUser.details.fullName)
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
                    Button("Send Message"){
                    }
                    .capsuleButton(color: .Blue, fontsize: 18)
                    .offset(y: -25)
                }.padding(.top, 70)
                PhotoView.Avatar(size: 140, isCell: true)
                    .onTapGesture {
                        showProfile = true
                    }
            }
            Spacer()
        }
        .sheet(isPresented: $showProfile) {
            MatchProfileView(user: todayUser)
        }
        .tabItem{ Image("heart") }
        .tag(2)
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
        TodayView()
    }
}
