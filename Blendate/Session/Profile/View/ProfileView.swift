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
        ScrollView(showsIndicators: false) {
            ProfileCardView($user.details, profileType, user.id)
                .environmentObject(sheet)
            bio
            infocards
            PhotosGridView($user.details.photos)
            interests
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.LightGray)
        .sheet(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
    }
}

extension ProfileView {
    func noInfo()->Bool{
        for group in InfoType.allCases {
            if group.show(user.details) {
                return false
            }
        }
        return true
    }
    
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
            EditDetailsView($user)
        case .filter:
            FiltersView(user: $user)
        case .settings:
            SettingsView(user: $user)
        default:
            EmptyView()
        }
    }
}


class ProfileSheet: SheetState<ProfileSheet.State> {
    enum State: String, CaseIterable {
        case edit = "Edit"
        case filter = "Filters"
        case settings = "Settings"
        
        var image: String {
            switch self {
            case .edit:
                return "pencil"
            case .filter:
                return "Filter"
            case .settings:
                return "settings"
            }
            
        }
    }
}

