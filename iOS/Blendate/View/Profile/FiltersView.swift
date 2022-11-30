//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var premium: PremiumViewModel

    @State var drinking: String = "Open to all"
    @State var smoking: String = "Open to all"
    @State var cannabis: String = "Open to all"
    
    @State var showMembership = false

    var isParent: Bool {
        session.user.filters.isParent
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Detail.FilterGroup.allCases){ group in
                    Section {
                        ForEach(group.cells(isParent: isParent)) { cell in
                            DetailCellView(detail: cell, details: $session.user, type: .filter, showMembership: $showMembership)
                        }
                    } header: {
                        HStack {
                            Text(group.id)
                            if group == .premium {
                                Image(systemName: premium.hasPremium ? "lock.open" : "lock")
                            }
                        }
                    }
                    .textCase(nil)

                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
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
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
