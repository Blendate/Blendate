//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI
import FirebaseFunctions
import FirebaseFirestoreSwift

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
    
    func swipe(_ swipe: Swipe.Action, on user: User?, superLikes: Int) throws {
        print("Swiped: \(swipe.rawValue)")
        do {
            guard let fid = user?.id else { throw FireStore.Error.noID}
            if swipe == .superLike, superLikes < 1 { throw Swipe.SuperLike() }
            
            Task { @MainActor in
                if let match = try await firestore.swipe(swipe, on: fid, from: uid) {
                    print(match.id ?? "No ID")
                    self.match = match
                } else {
                    lineup.removeFirst()
                    presenting = lineup.first
                }
            }
        } catch let error as ErrorAlert  {
            throw error
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchLineup(for user: User) async {
        guard lineup.isEmpty else { loading = false ; return}
        
        do {
            let fetched = try await fetch(for: user)
            self.lineup = fetched
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
    
}
extension SwipeViewModel {

    
    private func fetch(for session: User) async throws -> [User] {
        guard let uid = session.id else { return []}
        
        let seeking = session.filters.seeking
        let gender = session.gender
        
        let swipedUIDs: [String] = try await FireStore.instance.getHistory(for: uid)
        let path = CollectionPath.Users
        let collection = FireStore.instance.firestore.collection(path)

        let snapshot = try await collection.getDocuments().documents
        print("Got \(snapshot.count) Documents")
        let lineup: [User] = snapshot
            .filter { document in
                let fid = document.documentID
                return !swipedUIDs.contains(fid) && fid != uid
            }
            .compactMap { document in
                do { return try document.data(as: User.self) }
                catch { print("Decode Error for \(document.documentID)", error); return nil }
            }
            .filter { user in
                print("Check Gender: \(user.gender)")
                print("Check Seeking: \(user.filters.seeking)")
                if seeking.rawValue == "none" && user.filters.seeking.rawValue == "none" { return true}
                guard seeking.rawValue != "none" else { return user.filters.seeking == gender}
                return user.gender == seeking && user.filters.seeking == session.gender
            }
        
        return lineup

    }
}

