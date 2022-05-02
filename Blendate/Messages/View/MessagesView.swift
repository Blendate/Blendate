//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import MapKit

struct MessagesView: View {
    @StateObject var vm: MessagesViewModel

    init(){
        ColorNavbar()
        self._vm = StateObject(wrappedValue: MessagesViewModel())

    }
    var body: some View {
        NavigationView {
            VStack{
                matches
                messages
                Spacer()
            }
            .navigationTitle("Blends")
        }
    }
    
    var matches: some View {
        let matches = vm.allConvos.filter({ $0.lastMessage.isEmpty })
        return Group {
            if matches.isEmpty {
                emptyMatches
            }
            else {
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        ForEach(matches, id:\.self.timestamp){ match in
                            MatchAvatarView(match)
                        }
                    }
                    .padding(.leading)
                }
                .frame(height: 120, alignment: .center)
                .padding(.leading)
            }
        }
    }
    

    
    var messages: some View {
        let conversations = $vm.allConvos.filter({ !$0.lastMessage.wrappedValue.isEmpty })

        return Group {
            if conversations.isEmpty {
                noConvos
            } else {
                VStack {
                    messageDivider
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            ConvoCellView(conversation: conversation)
                        }
                    }.listStyle(.plain)
                }
            }
        }
    }

}

extension MessagesView {
    
    var emptyMatches: some View {
        Text("Match with profiles to Blend with others")
            .fontType(.regular, 18, .DarkBlue)
            .frame(height: 120, alignment: .center)
            .padding(.horizontal)
    }
    
    var noConvos: some View {
        VStack{
            Divider()
            Image("Interested")
                .resizable()
                .scaledToFill()
                .frame(width: 270, height: 226 , alignment: .center)
            Text("Tap on any of your matches to start a conversation")
                .fontType(.regular, 18, .DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top)
            Spacer()
        }
    }
    
    
    var messageDivider: some View {
        VStack(spacing:0){
            HStack{
                Text("Messages")
                    .fontType(.bold, 28, .DarkBlue)
                    .padding(.bottom, 4)
                Spacer()
            }.padding(.leading)
            Rectangle()
                .fill(Color.DarkBlue)
                .frame(width: getRect().width * 0.9, height: 1)
        }.padding(.bottom, 10)
    }
}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
