//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI


struct EditDetailsView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @Binding var user: User
    @Binding var settings: UserSettings
    @Binding var details: UserDetails
    
    init(_ user: Binding<User>){
        self._user = user
        self._settings = user.settings
        self._details = user.details
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: PremiumHeader(user: $user)) {
                    premium
                }.headerProminence(.increased)
                ForEach(Detail.Groups.allCases){ group in
                    Section(header: Text(group.id).foregroundColor(.DarkBlue)) {
                        if group == .children {
                            isParent
                        } else {
                            ForEach(group.cells) {cell in
                                DetailCellView(cell, $details)
                            }
                        }
                    }.headerProminence(.increased)
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var premium: some View {
        Group {
            ColorPicker("Profile Card", selection: $details.color, supportsOpacity: false)
            Toggle("Hide Age", isOn: $settings.hideAge).tint(.Blue)
        }.disabled(!settings.premium)
            .foregroundColor(settings.premium ? .DarkBlue:.gray)

    }
    
    var isParent: some View {
        Group {
            if details.isParent {
                ForEach(Detail.Groups.children.cells) {cell in
                    DetailCellView(cell, $details)
                }
            } else {
                DetailCellView(.parent, $details)
                DetailCellView(.wantKids, $details)

            }
        }
    }
}

struct PremiumHeader: View {
    @State var showMembership = false
    @Binding var user: User
    
    var body: some View {
        let premium = user.settings.premium
        Button(action: {
            showMembership = true
        }) {
            HStack {
                Text("Premium")
                    .foregroundColor(premium ? .DarkBlue:.gray)
                Image(systemName: premium ? "lock.open.fill":"lock.fill")
                    .foregroundColor(premium ? .DarkBlue:.gray)
                Spacer()
                if !premium {
                    Text("Upgrade")
                }
            }
        }.disabled(premium)
        .sheet(isPresented: $showMembership) {
            do {
                try UserService().updateUser(with: user)
            } catch {
                print("There was a problem saving your settings, please check your connection and try again")
            }
        } content: {
            MembershipView(membership: $user.settings.premium)
        }
    }
}





struct EditProfile_Previews: PreviewProvider {
    @State static var details = dev.michael.details
    static var previews: some View {
        EditDetailsView(.constant(dev.michael))
    }
}


extension EditDetailsView {
    func viceString()->String?{
        if !details.vices.isEmpty {
            let first = details.vices.map({$0}).prefix(upTo: 2).joined(separator:", ")
            let moreAmount = details.vices.count - 2
            
            let more = moreAmount < 1 ? "":" +\(moreAmount) more"
            
            return first + more
        } else {
            return nil
        }
    }
}
