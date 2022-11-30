//
//  EditProfileView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var premium: PremiumViewModel
    @State private var showMembership = false
    @Binding var details: User
    @State private var edit = true
    var body: some View {
        NavigationStack {
            VStack {
                editControl
                Divider()
                if edit {
                    List {

                        detailsView
                    }.listStyle(.grouped)
                    Spacer()
                } else {
                    ViewProfileView(details: details)
                }
            }
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") {
                    dismiss()
                }
            }
            .fullScreenCover(isPresented: $showMembership){
                MembershipView()
                    .environmentObject(premium)
            }
        }
    }
    
    var premiumSection: some View {
        Section {
                Button{
                    if !premium.hasPremium {
                        showMembership = true
                    }
                } label: {
                    VStack {
                        ToggleView("Invisivle Blending", value: $premium.settings.premium.invisbleBlending)
                        ToggleView("Hide Age", value: $premium.settings.premium.hideAge)
                    }
                }

        } header: {
            Text("Premium")
        }.textCase(nil)
            .disabled(!premium.hasPremium)
    }
    
    var detailsView: some View {
        ForEach(Detail.DetailGroup.allCases){ group in
            Section {
                ForEach(group.cells(isParent: details.info.isParent)) { cell in
                    DetailCellView(detail: cell, details: $details, type: .detail, showMembership: $showMembership)
                }
            } header: {
                Text(group.id)
            }.textCase(nil)
        }
    }
    
    var editControl: some View {
        HStack {
            Spacer()
            Button("Edit"){ edit = true }
                .foregroundColor(edit ? .Blue : .gray)
            Spacer()
            Button("Preview"){ edit = false }
                .foregroundColor(edit ? .gray : .Blue)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .fontType(.semibold, .title)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(details: .constant(dev.michael))
    }
}
