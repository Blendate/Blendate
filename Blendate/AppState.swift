//
//  AppState.swift
//  Blendate
//
//  Created by Michael on 8/4/21.
//

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var error: String?
    @Published var user: User?
    @State var loading = false
    @Published var currentView: InitialScreen = .loading
    @Published var selectedTab: Int = 4
    
    @Published var lineup: [MatchUser] = []
    
    init(_ lineup: [MatchUser] = []){
        self.lineup = lineup
    }
}

let app = App(id: "blendate-nynnv")
class AppState2: ObservableObject {
    
    @Published var error: String?
    @Published var busyCount = 0
    
    var loginPublisher = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublisher = PassthroughSubject<Void, Error>()
    let userRealmPublisher = PassthroughSubject<Realm, Error>()
    var cancellables = Set<AnyCancellable>()

    var shouldIndicateActivity: Bool {
        get {
            return busyCount > 0
        }
        set (newState) {
            if newState {
                busyCount += 1
            } else {
                if busyCount > 0 {
                    busyCount -= 1
                } else {
                    print("Attempted to decrement busyCount below 1")
                }
            }
        }
    }

    @Published var user: User?
    @State private var loading = false
    
    var loggedIn: Bool {
        app.currentUser != nil && user != nil && app.currentUser?.state == .loggedIn
    }
    
    @Published var currentView: InitialScreen = .loading
    @Published var selectedTab: Int = 4


    init() {
//        _  = app.currentUser?.logOut()
//        signIn()
//        initLoginPublisher()
//        initUserRealmPublisher()
//        initLogoutPublisher()
//        signIn()
    }
    
    func signIn(){
        if let current = app.currentUser {
            print("there is a user: \(current.id)")
            loginPublisher.send(current)
        }
    }
    
    func initLoginPublisher() {
        loginPublisher
            .receive(on: DispatchQueue.main)
            .flatMap { user -> RealmPublishers.AsyncOpenPublisher in
                self.shouldIndicateActivity = true
                let realmConfig = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfig)
            }
            .receive(on: DispatchQueue.main)
            .map {
                return $0
            }
            .subscribe(userRealmPublisher)
            .store(in: &self.cancellables)
    }
    
    func initUserRealmPublisher() {
        userRealmPublisher
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.error = "Failed to log in and open user realm: \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("User Realm User file location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(User.self).first
                do {
                    try realm.write {
                        self.user?.presenceState = .onLine
                    }
                } catch {
                    self.error = "Unable to open Realm write transaction"
                }
                self.shouldIndicateActivity = false
                if self.user?.userPreferences != nil {
                    self.currentView = .session
                }
            })
            .store(in: &cancellables)
    }
    
    func initLogoutPublisher() {
        logoutPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self.user = nil
            })
            .store(in: &cancellables)
    }
    
    
}
