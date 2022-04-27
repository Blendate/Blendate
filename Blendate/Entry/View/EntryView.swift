//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI

struct EntryView: View {
    @StateObject var loadingState: FirebaseAuthState
    init(){ self._loadingState = StateObject(wrappedValue: FirebaseAuthState()) }
    
    var body: some View {
        Group {
            switch loadingState.state {
            case .loading:
                LaunchView()
            case .noUser:
                WelcomeView()
            case .uid(let uid):
                SessionView(uid)
            }
        }.preferredColorScheme(.light)
    }
}

@MainActor
class FirebaseAuthState: ObservableObject {

    @Published var state:FirebaseState = .loading
        
    init(){
        FirebaseManager.instance.auth.addStateDidChangeListener { (_,user) in
          if let uid = user?.uid {
              self.state = .uid(uid)
          } else {
              self.state = .noUser
          }
      }
    }
}
