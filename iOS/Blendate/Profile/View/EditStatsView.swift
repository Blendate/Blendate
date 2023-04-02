//
//  EditStatsView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct EditStatsView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var user: User
    @Binding var settings: User.Settings
    
    let isFilter: Bool
    var isParent: Bool {
        isFilter ? user.filters.isParent : user.info.isParent
    }
    
    @State private var alert: ErrorAlert?
    @State var showProfile = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(DetailGroup.allCases){ group in
                    if !group.cells(isFilter: isFilter, isParent: isParent).isEmpty {
                        Section {
                            let cells = group.cells(isFilter: isFilter, isParent: isParent)
                            ForEach(cells){ detail in
                                DetailCell(detail: detail, user: $user, isFilter: isFilter)
                            }
                        } header: {
                            header(for: group)
                        }
                    }

                }
            }
            .listStyle(.grouped)
            .toolbar {
                if !isFilter {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Preview"){ self.showProfile = true }
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: save)
                        .fontWeight(.semibold)
                }
            }
            .errorAlert(error: $alert){ error in
                Button("Try Again", action: save)
                Button("Cancel", role: .cancel){ dismiss() }
            }
            .sheet(isPresented: $showProfile){
                ViewProfileView(user: user)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(isFilter ? "Filters" : "Details")
        }
    }
     
    func header(for group: DetailGroup) -> some View {
        HStack {
            Image(systemName: group.systemImage)
            Text(group.id)
        }
        .foregroundColor(group == .premium ? .Purple : .DarkBlue)
        .fontWeight(.semibold)
    }
    
    func save(){
        do {
            try FireStore.instance.update(user)
            dismiss()
        } catch let error as ErrorAlert {
            self.alert = error
            print(error.localizedDescription)
        } catch {
            self.alert = FireStore.Error.noID
            print(error.localizedDescription)
        }
    }
}



struct EditStatsView_Previews: PreviewProvider {
    static var previews: some View {
        EditStatsView(user: .constant(alice), settings: .constant(User.Settings()), isFilter: true)
        EditStatsView(user: .constant(alice), settings: .constant(User.Settings()), isFilter: false)
    }
}
