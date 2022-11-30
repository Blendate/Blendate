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
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var match: MatchViewModel
    @EnvironmentObject var premium: PremiumViewModel
    
    init(uid: String){
        self._vm = StateObject(wrappedValue: MessagesViewModel(uid: uid))
    }
    
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
            if vm.matches.isEmpty {
                emptyMatches
            }
            else {
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 15){
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
            if premium.hasPremium {
                session.selectedTab = .likes
            } else {
                premium.showMembership = true
            }
        } label: {
            ZStack {
                Circle()
                    .stroke( Color.DarkBlue,lineWidth: 2)
                    .frame(width: 80, height: 80, alignment: .center)
                PhotoView.Avatar(url: match.lineup.last?.avatar, size: 70, isCell: true)
                    .blur(radius: premium.hasPremium ? 0 : 20)
                    .clipShape(Circle())
//                    Circle().fill(Color.Blue)
//                        .frame(width: 70, height: 70)
                VStack(spacing: 0) {
                    Text("10")
                    Text("Likes")
                }
                .fontType(.semibold, .body, .white)
            }
        }

    }
    
    
    var messages: some View {
        VStack {
            HStack {
                Text(Self.Messages)
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
            Text(Self.EmptyMatches)
                .fontType(.semibold, 18, .DarkBlue)
            Spacer()
        }.padding(.leading)
    }
    
    var noConvos: some View {
        let message = vm.allConvos.isEmpty ? Self.NoMatches : Self.NoConversations
        
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
        .navigationTitle(Self.Title)
    }
}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(uid: dev.tyler.id!)
    }
}
