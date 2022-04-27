//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI


struct SettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    init(user: Binding<User>){
        self._user = user
        ColorNavbar()
    }
    @Binding var user: User
    @State var showPremium: Bool = false
    
    var distanceProxy: Binding<Bool>{
        Binding<Bool>(
            get: {
                return user.settings.dev?.classicTab ?? false
        }, set: {
            user.settings.dev = Dev(classicTab: $0)
        })
    }
    

    var body: some View {
        NavigationView {
            List {
                ForEach(SettingCell.Groups.allCases){ group in
                    Section(header: Text(group.id)) {
                        ForEach(group.cells){ cell in
                            if cell != .invisble {
                                SettingCellView(cell, $user.settings)
                            } else {
                                if user.settings.premium {
                                    SettingCellView(cell, $user.settings)
                                }
                            }
                        }
                    }
                }
                LogoutButtons
                Section(header: Text("Dev")){
                    Toggle("Classic Tab Bar", isOn: distanceProxy)
                    Text("May have to restart the app to show the change")
                }
            }
            .listStyle(.insetGrouped)
            .foregroundColor(.DarkBlue)
            .background(Color.LightGray)
            .navigationBarTitle("Settings")
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
            Button(action: signout) {
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
        mode.wrappedValue.dismiss()
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
