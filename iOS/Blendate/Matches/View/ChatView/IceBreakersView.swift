//
//  IceBreakersView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct IceBreakersView: View {
    @State var icebreaker = Icebreakers.allCases.randomElement()!
    @Binding var chatText: String
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Spacer()
                Image(icebreaker.rawValue)
                Text(icebreaker.title)
                    .font(.title3.weight(.semibold), .DarkBlue)
                Spacer()
            }
            .onTapGesture {
                chatText = icebreaker.text
            }
            Text("Tap on a prompt to send a message")
                .padding(.top, 2)
                .foregroundColor(.gray)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                var new = Icebreakers.allCases.randomElement()!
                while new == icebreaker {
                    new = Icebreakers.allCases.randomElement()!
                }
                icebreaker = new
            }
        }
    }
}


struct IceBreakersView_Previews: PreviewProvider {
    static var previews: some View {
        IceBreakersView(chatText: .constant(""))
    }
}
