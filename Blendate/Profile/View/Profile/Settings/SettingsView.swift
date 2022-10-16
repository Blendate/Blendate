//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI


struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var user: User
    @State var showPremium: Bool = false
    @State var alertError: AlertError?

    var body: some View {
        NavigationView {
            List {
                ForEach(SettingCell.Groups.allCases){ group in
                    Section {
                        ForEach(group.cells){ cell in
                            if cell != .invisble {
                                SettingCellView(cell, $user.settings)
                            } else {
                                if user.settings.premium {
                                    SettingCellView(cell, $user.settings)
                                }
                            }
                        }
                    } header: {
                        Text(group.id)
                    }.textCase(nil)
                }
                LogoutButtons
            }
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") {
                    dismiss()
                }
            }
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.DarkBlue)
            .background(Color.LightGray)
            .navigationBarTitle("Settings")
            .errorAlert(error: $alertError, retry: delete)
        }
    }
    
    var LogoutButtons: some View {
        Section {
            Button(action: signout) {
                HStack {
                    Spacer()
                    Text("Logout")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
            Button(action: showDeleteAlert) {
                HStack {
                    Spacer()
                    Text("Delete Account")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
    }
    
    private func signout(){
        dismiss()
        try? FirebaseManager.instance.auth.signOut()
    }
    
    private func showDeleteAlert(){
        self.alertError = AlertError(errorDescription: "Delete Account", failureReason: "Are you sure you want to delete your account?", recoverySuggestion: "Delete")
    }
    
    private func delete(){
        dismiss()
        FirebaseManager.instance.auth.currentUser?.delete()
        try? FirebaseManager.instance.auth.signOut()

    }
}



struct ProviderCell: View {
    let provider: AuthType
    @Binding var userProviders: [Provider]
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(provider.id)
            }
            Spacer()
            if let prov = checkPovider(with: provider){
                Text(prov.email)
            } else {
                HStack{
                    Text("Link")
                    Image(systemName: "chevron.right")
                }
            }
        }.padding(.vertical, 5)
        .listRowBackground(Color.white)
    }
    
    func checkPovider(with provider: AuthType)->Provider?{
        return userProviders.first(where: {$0.type == provider})
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: .constant(dev.michael))
    }
}
