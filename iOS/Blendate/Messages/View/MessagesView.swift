//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import MapKit

struct MessagesView: View {
    @StateObject var vm = MessagesViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if vm.allConvos.isEmpty {
                    noConvos
                } else {
                    VStack{
                        matches
                        messages
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.icon(40).foregroundColor(.Blue)
                }
            }
        }
    }
    
    var matches: some View {
        VStack {
            HStack {
                Text("Matches")
                    .fontType(.bold, .title3, .DarkBlue)
                    .padding(.leading)
                Spacer()
            }
            if vm.matches.isEmpty {
                emptyMatches
            }
            else {
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 20){
                        likedYou
                        ForEach(vm.matches.sorted(by: {$0.timestamp > $1.timestamp})){ match in
                            MatchAvatarView(match)
                        }
                    }
                    .padding(.leading)
                }
                .frame(height: 120, alignment: .center)
                .padding(.leading)
            }
        }.padding(.vertical)
    }
    
    var likedYou: some View {
        Button {
            
        } label: {
            VStack {
                ZStack {
                    Circle().fill(Color.Blue)
                        .frame(width: 70, height: 70)
                    Text("10")
                        .fontType(.semibold, .title3, .white)
                        .fixedSize()
                }
                Text("Likes")
            }
        }

    }
    

    
    var messages: some View {
        VStack {
            HStack {
                Text("Messages")
                    .fontType(.bold, .title3, .DarkBlue)
                    .padding(.leading)
                Spacer()
            }
            if vm.conversations.isEmpty {
                noConvos
            } else {
                List {
                    ForEach(vm.conversations, id: \.id) { conversation in
                        ConvoCellView(conversation: conversation)
                    }
                }.listStyle(.plain)
            }
        }
    }

}

extension MessagesView {
    
    var emptyMatches: some View {
        HStack(alignment: .top) {
            likedYou
            Text("Match with profiles to Blend with others")
                .fontType(.semibold, 18, .DarkBlue)
            Spacer()
        }.padding(.leading)
    }
    
    var noConvos: some View {
        let message = vm.allConvos.isEmpty ?
            "Start matching with profiles to blend with others and start conversations":
            "Tap on any of your matches to start a conversation"
        
        return VStack {
            Spacer()
            VStack{
                Divider()
                Image("Interested")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 270, height: 226 , alignment: .center)
                Text(message)
                    .fontType(.semibold, 18, .DarkBlue)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                Spacer()
            }
        }
        .navigationTitle("Blends")
        

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
