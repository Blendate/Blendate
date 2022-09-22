//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var sheet = ProfileSheet()
    @Binding var user: User
    
    init(_ user: Binding<User>){
        self._user = user
    }
    
    var body: some View {
        NavigationView {
            List {
                profileCard
                    .listRowSeparator(.hidden)
                ForEach(EditDetail.DetailGroup.allCases){ group in
                    Section {
                        ForEach(group.cells(user.details)) { cell in
                            DetailCellView(detail: cell, details: $user.details)
                        }
                    } header: {
                        if group != .general {
                            Text(group.id)
                                .fontType(.bold, 20, .DarkBlue)
                        }
                    }
                }
            }
            .listStyle(.plain)
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
        }
        .tabItem{ Image("profile") }

    }
    
    var profileCard: some View {
        ProfileCardView(user.details, .session, user.id)
            .environmentObject(sheet)
            .padding(.vertical)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
            .sheet(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
            .buttonStyle(BorderlessButtonStyle())
    }
    
    var premium: some View {
        Group {
            ColorPicker("Profile Card", selection: $user.details.color, supportsOpacity: false)
            Toggle("Hide Age", isOn: $user.settings.hideAge).tint(.Blue)
        }
        .disabled(!user.settings.premium)
        .foregroundColor(user.settings.premium ? .DarkBlue:.gray)

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
            MatchProfileView(user: user)
        case .filter:
            FiltersView($user.filters)
        case .settings:
            SettingsView(user: $user)
        default:
            EmptyView()
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(dev.$bindingMichael)
            .environmentObject(ProfileSheet())
    }
}

