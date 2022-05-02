//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var session: SessionViewModel
    @Binding var user: User

    var body: some View {
        NavigationView {
            SignupViewMod($user.details, .name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { try? FirebaseManager.instance.auth.signOut() }) {
                            Image(systemName: "chevron.left")
                                .tint(.Blue)
                        }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
//


extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace }) || isEmpty || self == "--"
  }
}

