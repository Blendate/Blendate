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
                .fontType(.regular, 42, .Blue)
                .padding(.top, 40)
            Spacer()
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: getRect().width * 0.9, height: getRect().width * 0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 4).foregroundColor(.Blue))
//                            .stroke(Color.Blue))
                    VStack {
                        Text(todayUser.details.fullName())
                            .fontType(.bold, 24)
                            .foregroundColor(.DarkBlue)
                        Text("Send a short message and start chating!")
                            .fontType(.regular, 12)
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        TextView(text: $message)
                            .frame(width: getRect().width * 0.7, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
//                            .background(Color.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .background(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.gray))
                            .disabled(true)
                    }
                }
                .frame(width: getRect().width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color.Blue)
                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Circle()
                            .stroke(Color(UIColor(red: 0.757, green: 0.334, blue: 0.863, alpha: 1)), lineWidth: 6)
                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
//                        PhotoView($todayUser.details.photos[0], edit: false)
//                            .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    .offset(y: -180)
                    , alignment: .top)

                .overlay(
                    SaveConversationButton(members: [todayUser.id ?? ""]){
                        
                    }
                    , alignment: .bottom)
                
            }
//            .offset(y: getRect().height * 0.175)
            
            .padding()
            Spacer()
        }
//            Rectangle()
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.DarkBlue,Color.DarkPink]),
//                                     startPoint: .topLeading, endPoint: .bottomTrailing))
//                .edgesIgnoringSafeArea(.all)
//
//        )
        
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

struct SaveConversationButton: View {

    let members: [String]
    var done: () -> Void = { }


    var body: some View {
        Button(action: saveConversation, label: {
            Text("Send Message")
                .fontType(.semibold, 16)
                .foregroundColor(.white)
                .frame(width: getRect().width * 0.45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Capsule()
                                .fill(Color.Blue)
                                .shadow(color: Color(#colorLiteral(red: 0.3446457386, green: 0.3975973725, blue: 0.9629618526, alpha: 0.2406952713)), radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5))
                .offset(y:getRect().height * 0.175)
        })
    }

    private func saveConversation() {

    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
