//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import MapKit

struct MatchesView: View {
    @EnvironmentObject var model: MatchesViewModel

    
    var body: some View {
        NavigationView {
            Group {
                if model.fetched.isEmpty {
                    EmptyMatchs(model.fetched)
                } else {
                    VStack{
                        Matches(matches: model.matches)
                        Messages(conversations: model.conversations)
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
}

extension MatchesView {
    
    struct MatchCell: View {
        @EnvironmentObject var settings: SettingsViewModel
        
        let match: Match
        @State var details: User?
        var blur: Bool = false
        
        var body: some View {
            if let cid = match.id {
                NavigationLink {
                    ChatView(cid, with: $details)
                } label: {
                    VStack {
                        ZStack{
                            Circle()
                                .stroke(  Color.DarkBlue, lineWidth: 2)
                                .frame(width: 80, height: 80, alignment: .center)
                            image
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        
        @ViewBuilder
        var image: some View {
            if blur {
                PhotoView.MatchAvatar(match: match, details: $details)
                .blur(radius: settings.hasPremium ? 0 : 20)
                .clipShape(Circle())
            } else {
                PhotoView.MatchAvatar(match: match, details: $details)

            }
        }
    }
    
    struct Matches: View {
        @EnvironmentObject var session: SessionViewModel
        @EnvironmentObject var settings: SettingsViewModel
        
        var matches: [Match]
        var body: some View {
            VStack {
                if matches.isEmpty {
                    emptyMatches
                }
                else {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 15){
                            likedYou
                            ForEach(matches){ MatchCell(match: $0) }
                        }
                        .padding(.leading)
                    }
                    .padding(.vertical, 4)
//                    .frame(height: 125, alignment: .center)
                    .padding(.leading)
                }
            }.padding(.vertical)
        }
        
        var emptyMatches: some View {
            HStack(alignment: .top) {
                likedYou
                Text("Match with profiles to Blend with others")
                    .fontType(.semibold, 18, .DarkBlue)
                Spacer()
            }.padding(.leading)
        }
        
        
        var likedYou: some View {
            Button {
                if settings.hasPremium {
                    session.selectedTab = .likes
                } else {
                    settings.showMembership = true
                }
            } label: {
                ZStack {
                    if let firstLike = matches.first {
                        MatchCell(match: firstLike, blur: true)
                    } else {
                        Circle().fill(Color.Blue)
                            .frame(width: 70, height: 70)
                    }


                    VStack(spacing: 0) {
                        Text("10")
                        Text("Likes")
                    }
                    .fontType(.semibold, .body, .white)
                }
            }

        }
    }

}

extension MatchesView {
    
    struct Messages: View {
        var conversations: [Match]
        
        var body: some View {
            VStack {
                HStack {
                    Text("Messages")
                        .fontType(.bold, .title3, .DarkBlue)
                        .padding(.leading)
                    Spacer()
                }
                if conversations.isEmpty {
                    EmptyMatchs(conversations)
                } else {
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            ConvoCellView(conversation: conversation)
                        }
                    }.listStyle(.plain)
                }
            }
        }
    }
    
    struct EmptyMatchs: View {
        let conversations: [Match]
        init(_ conversations: [Match]) {
            self.conversations = conversations
        }
        let NoMatchs = "Tap on any of your matches to start a conversation"
        let NoMatches = "Start matching with profiles to blend with others and start conversations"
        var message: String { conversations.isEmpty ? NoMatches : NoMatchs }
        
        var body: some View {
            VStack {
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
    }



}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
            .environmentObject(MatchesViewModel(dev.tyler.id!))
    }
}
