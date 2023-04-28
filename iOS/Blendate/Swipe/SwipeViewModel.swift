//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI
import FirebaseFunctions

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
}
extension SwipeViewModel {
    

    
    @MainActor
    func fetchLineup(for user: User) async {
        guard lineup.isEmpty else { loading = false ; return}

        do {
            let fetched = try await fetch(for: user)
//            self.lineup = filterLineup(for: user, from: fetched)
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
    

    
    private func fetch(for session: User) async throws -> [User] {
        guard let uid = session.id else { return []}
        
        let seeking = session.filters.seeking
        let gender = session.info.gender
        
        let swipedUIDs: [String] = try await FireStore.instance.getHistory(for: uid)
        let path = CollectionPath.Users
        let collection = FireStore.instance.firestore.collection(path)

        let snapshot = try await collection.getDocuments().documents

        let lineup: [User] = snapshot
            .filter { document in
                let fid = document.documentID
                return !swipedUIDs.contains(fid) && fid != uid
            }
            .compactMap { document in
                do { return try document.data(as: User.self) }
                catch { print("Decode Error for \(document.documentID)", error); return nil }
            }
//            .filter { user in
//                print("Check Gender: \(user.info.gender ?? "None")")
//                print("Check Seeking: \(user.filters.seeking ?? "None")")
//                if seeking == String.kOpenString && (user.filters.seeking == String.kOpenString || user.filters.seeking == nil ){ return true}
//                guard seeking != String.kOpenString else { return user.filters.seeking == gender}
//                return user.info.gender == seeking && user.filters.seeking == session.info.gender
//            }
        
        return lineup

    }
}

//@MainActor
//func fetchLineup() async {
//    let functions = Functions.functions()
//    do {
//        let result = try await functions.httpsCallable("fetchLineup").call( ["uid": uid] )
//        guard let dictionary = result.data as? [Any] else { print("No Object");loading = false; return }
//        Swift.print(dictionary.count)
//        Swift.print(dictionary[0])
//
//
//        let lineup = try dictionary.compactMap {
//            let jsonData = try JSONSerialization.data(withJSONObject: $0, options: [])
//            let user: User? = try? JSONDecoder().decode(User.self, from: jsonData)
//            print(user?.id ?? "ID")
//            return user
//        }
//        print("Lineup: \(lineup.count)")
//        self.lineup = lineup
//    } catch {
//        print(error)
//    }
//    print("Done")
//    loading = false
//}
//
