//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var session: SessionViewModel

    @State var showMembership = false

    var isParent: Bool {
        session.user.filters.isParent
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(FilterGroup.allCases){ group in
                    Section {
                        let cells = group.cells(isParent: isParent)
                        ForEach(cells) { cell in
                            DetailCellView(
                                detail: cell,
                                details: $session.user,
                                type: .filter,
                                showMembership: $showMembership)
                        }
                    } header: {
                        HStack {
                            Text(group.id.capitalized)
                            if group == .premium {
                                Image(systemName: settings.hasPremium ? "lock.open" : "lock")
                            }
                        }
                        .foregroundColor(.DarkBlue)
                        .fontWeight(.semibold)
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
                    .environmentObject(settings)
            }
        }

    }

}

extension FiltersView {
    
    enum FilterGroup: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general, personal, children, background, premium

        func cells(isParent: Bool) -> [Detail] {
            switch self {
            case .general:
                return [.maxDistance, .ageRange, .seeking]
            case .children:
                if isParent {
                    return [.isParent, .children, .familyPlans]
                } else {
                    return [.isParent, .familyPlans]
                }
            case .personal:
                return [.relationship]
            case .background:
                return [.religion, .ethnicity]
            case .premium:
                return Detail.allCases.filter{$0.isPremium}
            }
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
            .environmentObject(SessionViewModel(user: dev.michael))
    }
}
