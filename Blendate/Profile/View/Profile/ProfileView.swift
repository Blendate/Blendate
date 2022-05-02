//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI


struct ProfileView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @StateObject var sheet = ProfileSheet()
    @Binding var user: User
    @Binding var settings: UserSettings
    @Binding var details: Details
    
    init(_ user: Binding<User>){
        self._user = user
        self._settings = user.settings
        self._details = user.details
    }
    
    var body: some View {
        NavigationView {
            List {
                ProfileCardView(user.details, .session, user.id)
                    .environmentObject(sheet)
                    .padding(.vertical)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                    .sheet(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
                    .buttonStyle(BorderlessButtonStyle())

                Section {
                    HStack {
                        Text("Name")
                            .fontType(.semibold, 16, .gray)
                            .padding(.vertical, 15)
                        Spacer()
                        Text(details.fullName)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Age")
                            .fontType(.semibold, 16, .gray)
                            .padding(.vertical, 15)
                        Spacer()
                        Text(String(details.age))
                            .foregroundColor(.gray)
                    }
                }
//                Section(header: PremiumHeader(user: $user)) {
//                    premium
//                }
//                .headerProminence(.increased)
                ForEach(EditDetail.DetailGroup.allCases){ group in
                    if group == .general {
                        ForEach(group.cells(details)) { cell in
                            DetailCellView(detail: cell, details: $details)
                        }
                    } else {
                        Section(header: Text(group.id).foregroundColor(.DarkBlue)) {
                            ForEach(group.cells(details)) { cell in
                                DetailCellView(detail: cell, details: $details)
                            }
                        }
                        .headerProminence(.increased)
                    }

                }
            }
            .listStyle(.insetGrouped)
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

    }
    
    var premium: some View {
        Group {
            ColorPicker("Profile Card", selection: $details.color, supportsOpacity: false)
            Toggle("Hide Age", isOn: $settings.hideAge).tint(.Blue)
        }
        .disabled(!settings.premium)
        .foregroundColor(settings.premium ? .DarkBlue:.gray)

    }
}



struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(dev.$bindingMichael)
            .environmentObject(ProfileSheet())
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
        case .filter:
            FiltersView($user.filters)
        case .settings:
            SettingsView(user: $user)
        default:
            EmptyView()
        }
    }
}

