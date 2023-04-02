//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI

class SwipeViewModel: ObservableObject {
    
    /// is loading when fetching lineup
    @Published var loading = true
    @Published var lineup = [User]()
        
    @Published var presenting: User?
    @Published var match: Match?
    

    /// session uid
    private let uid: String
    private let firestore = FireStore.instance

    init(_ uid: String, presenting: User? = nil){
        self.uid = uid
        self.presenting = presenting
    }
    
    func nextLineup() { withAnimation {
        lineup.removeFirst()
        presenting = lineup.first
        if match != nil { self.match = nil }
    }}
    
    @MainActor
    func fetchLineup(for user: User) async {
        guard lineup.isEmpty else { loading = false ; return}
        
        do {
            let fetched = try await firestore.fetchLineup(for: uid)
            self.lineup = filterLineup(for: user, from: fetched)
            
            withAnimation {
                self.presenting = lineup.first
                loading = false
            }
            print("Fetched Lineup: \(lineup.count)")
        } catch {
            withAnimation { loading = false }
            print("Fetch Lineup", error)
        }
    }
    
    func swipe(_ swipe: Swipe.Action, on user: User?, superLikes: Int) throws {
        print("Swiped: \(swipe.rawValue)")
            do {
                guard let fid = user?.id else { throw FireStore.Error.noID}
                if swipe == .superLike, superLikes < 1 { throw Swipe.SuperLike() }
                
                Task { @MainActor in
                    if let match = try await firestore.swipe(swipe, on: fid, from: uid) {
                        self.match = match
                    } else {
                        nextLineup()
                    }
                }
            } catch let error as ErrorAlert  {
                throw error
            } catch {
                print(error.localizedDescription)
            }
    }
    
    private func filterLineup(for session: User, from users: [User]) -> [User] {
        let seeking = session.filters.seeking
        let gender = session.info.gender
        print("Seeking: \(seeking ?? "None")")
        print("Gender: \(gender ?? "None")")

        return users.filter { user in
            print("Check Gender: \(user.info.gender ?? "None")")
            print("Check Seeking: \(user.filters.seeking ?? "None")")
            if seeking == String.kOpenString && (user.filters.seeking == String.kOpenString || user.filters.seeking == nil ){ return true}
            guard seeking != String.kOpenString else { return user.filters.seeking == gender}
            return user.info.gender == seeking && user.filters.seeking == session.info.gender
        }
    }
}


