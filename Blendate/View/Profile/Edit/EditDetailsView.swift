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
    @Binding var details: Details
    
    init(_ user: Binding<User>){
        self._user = user
        self._settings = user.settings
        self._details = user.details
    }
    
    var body: some View {
        List {
            Section(header: PremiumHeader(user: $user)) {
                premium
            }
            .headerProminence(.increased)
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
        EditDetailsView(dev.$bindingMichael)
    }
}


extension EditDetailsView {
    func viceString()->String?{
        if !details.info.vices.isEmpty {
            let first = details.info.vices.map({$0}).prefix(upTo: 2).joined(separator:", ")
            let moreAmount = details.info.vices.count - 2
            
            let more = moreAmount < 1 ? "":" +\(moreAmount) more"
            
            return first + more
        } else {
            return nil
        }
    }
}
