//
//  ChatCellView.swift
//  Blendate
//
//  Created by Michael on 8/7/21.
//

import SwiftUI

struct ChatCellView: View {
    @EnvironmentObject var state: AppState
    var chat: ChatMessage
    
    func myMsg()->Bool {
        chat.author == state.user!.identifier
    }
    
    var body: some View {
        
        //SENDER
        if myMsg() {
            HStack {
                VStack(alignment:.leading) {
                    
                    HStack(alignment:.bottom) {
                        
                        VStack(alignment:.leading) {
                            
                            
                            Text(chat.text)
                                .font(.subheadline)
                                .foregroundColor( Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        .padding()
                        
                        .background(msgTail(myMsg: myMsg()).stroke(Color.DarkBlue, lineWidth: 2))
                        
                    }
                    Text("12:00 PM")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding(.trailing, 35)
            .padding()
        }
        //Receiver
        else{
            HStack {
                Spacer()
                VStack(alignment:.trailing) {
                    
                    HStack(alignment:.bottom) {
                        
                        
                        VStack(alignment:.leading) {
                            
                            Text(chat.text)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        }
                        .padding()
                        .background(msgTail(myMsg: myMsg()).stroke(Color.purple, lineWidth: 2))
                        //
                        
                        
                    }
                    HStack{
                        Image("Read")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFill()
                        Text("12:00 PM")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                }
                
            }
            .padding(.leading, 35)
            .padding()
        }
    }
    
}

struct msgTail : Shape{
    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path{
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,!myMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 25, height: 25))
        
        
        
        return Path(path.cgPath)
    }
}

struct ChatCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChatCellView(chat: ChatMessage())
    }
}

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}

extension InsettableShape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
