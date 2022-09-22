//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

enum ProfileType { case view, match, session }
struct MatchProfileView: View {
    
    @EnvironmentObject var vm: MatchViewModel
    @EnvironmentObject var session: SessionViewModel
    
    var viewUser: User?
    let profileType: ProfileType
    
    init(user: User? = nil){
        if let user = user {
            self.viewUser = user
            self.profileType = .view
        } else {
            self.profileType = .match
        }
    } 
    
    var body: some View {
        Group {
            if profileType == .view {
                viewProfile
            } else {
                matchProfile
                .task {
                    await vm.getLineup()
                }
            }
        }
        .transition(.opacity)
        .tabItem{ Image("icon-2") }
    }
        
    @ViewBuilder
    var matchProfile: some View {
        if !vm.loading {
            if let first = vm.lineup.first {
                profileView(first)
                .sheet(isPresented: $vm.matched) {
                    withAnimation(.spring()) {
                        vm.matched = false
                        vm.lineup.removeFirst()
                    }
                } content: {
                    MatchedView(show: $vm.matched, user: session.user, matchedWith: first)
                        .environmentObject(vm)
                }
                .animation(Animation.spring(), value: vm.lineup.first)
            } else {
                EmptyLineupView(sessionUser: $session.user)
            }
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder
    var viewProfile: some View {
        if let viewUser = viewUser {
            profileView(viewUser)
        }
    }
    
    @ViewBuilder
    func profileView(_ user: User)->some View {
        ScrollView(showsIndicators: false) {
            ProfileCardView(user.details, profileType, user.id)
            bio(user)
            infocards(user)
            PhotosGridView(user.details.photos)
            TagCloudView(tags: user.details.interests)
                .padding(.horizontal)
        }
    }
    @ViewBuilder
    func bio(_ user: User) -> some View {
        let bio = user.details.bio
        if !(bio.isEmpty) {
            Text(bio)
                .fontType(.regular, 16, .DarkBlue)
                .multilineTextAlignment(.leading)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func infocards(_ user:User) -> some View {
        let details = user.details
        if !noInfo(user) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(InfoType.allCases){ type in
                        if type.show(details){
                            InfoCard(type, details)
                        }
                    }
                }.padding()
            }
        }
    }
    
    private func noInfo(_ user: User)->Bool{
        for group in InfoType.allCases {
            if group.show(user.details) {
                return false
            }
        }
        return true
    }

}


struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MatchProfileView(user: dev.michael)
    }
}


