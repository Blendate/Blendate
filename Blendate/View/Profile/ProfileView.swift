//
//  ProfileView.swift
//  Blendate
//
//  Created by Michael on 6/1/21.
//

import SwiftUI
#warning("Fix Image Memory Leaks")

enum ProfileType { case view, match, session }
struct ProfileView: View {
    
    @StateObject var sheet = ProfileSheet()
    @Binding var user: User
    let profileType: ProfileType
    
    init(_ user: Binding<User>, _ type: ProfileType = .session){
        self._user = user
        self.profileType = type
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileCardView(user.details, .session, user.id)
                    .environmentObject(sheet)
                    .padding(.top)
                EditDetailsView($user)
            }
            .background(Color.LightGray)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        try? UserService().updateUser(with: user)
                    } label: {
                        Text("Save")
                            .fontType(.bold, 18, .Blue)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Image.icon(40, .Blue)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
        }
    }
}

extension ProfileView {

    private func save() {
        do {
            try UserService().updateUser(with: user)
        } catch {
            printD(error.localizedDescription)
            print("SAVE ERROR: error saving user")
        }
    }
    @ViewBuilder
    private func sheetContent() -> some View {
        switch sheet.state {
        case .edit:
            MatchProfileView(user: user)
//            EditDetailsView($user)
        case .filter:
            FiltersView($user.filters)
        case .settings:
            SettingsView(user: $user)
        default:
            EmptyView()
        }
    }
}
