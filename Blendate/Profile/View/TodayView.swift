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
    
    var body: some View {
        VStack{
            Text("Today's Blend")
                .fontType(.semibold, 42, .Blue)
                .padding(.top, 40)
            VStack(spacing: 0) {
                Circle()
                    .fill(Color.Blue)
                    .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(y: 70)
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
            }
            .offset(y: -70)
            Spacer()
        }
    }
    
}
//                .frame(width: getRect().width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .overlay(
//                    ZStack {
//                        Circle()
//                            .fill(Color.Blue)
//                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        Circle()
//                            .stroke(Color(UIColor(red: 0.757, green: 0.334, blue: 0.863, alpha: 1)), lineWidth: 6)
//                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    }
//                    .offset(y: -180)
//                    , alignment: .top)
//
//                .overlay(
//                    SaveConversationButton(members: [todayUser.id ?? ""]){
//
//                    }
//                    , alignment: .bottom)
                
//            }
//            .offset(y: getRect().height * 0.175)
            

//            Rectangle()
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.DarkBlue,Color.DarkPink]),
//                                     startPoint: .topLeading, endPoint: .bottomTrailing))
//                .edgesIgnoringSafeArea(.all)
//
//        )

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
