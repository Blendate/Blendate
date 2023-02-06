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
    
    @Binding var details: User
    @State private var showMembership = false
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(DetailGroup.allCases){ group in
                    Section {
                        let cells = group.cells(isParent: details.info.isParent)
                        ForEach(cells) { detail in
                            DetailCellView(
                                detail: detail,
                                details: $details,
                                type: .detail,
                                showMembership: $showMembership
                            )
                        }
                    } header: {
                        Text(group.id.capitalized)
                            .foregroundColor(.DarkBlue)
                            .fontWeight(.semibold)
                    }.textCase(nil)
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Preview") {
                    self.showProfile = true
                }
                ToolbarItem(placment: .navigationBarLeading, systemImage: "chevron.left") {
                    dismiss()
                }
            }
            .sheet(isPresented: $showProfile){
                ViewProfileView(details: details)
            }
            .fullScreenCover(isPresented: $showMembership){
                MembershipView()
                    .environmentObject(premium)
            }
        }
    }
}

extension EditProfileView {
    
    enum DetailGroup: String, Identifiable, CaseIterable {
        var id: String {self.rawValue}
        case general, personal, children, background, other
        
        func cells(isParent: Bool) -> [Detail] {
            switch self {
            case .general:
                return [.location, .photos]
            case .personal:
                return [.bio, .work, .education, .height, .relationship]
            case .children:
                if isParent {
                    return [.isParent, .children, .childrenRange, .familyPlans]
                } else {
                    return [.isParent, .familyPlans]
                }
            case .background:
                return [.religion, .ethnicity, .politics]
            case .other:
                return [.mobility, .vices, .interests]
            }
        }
    }
}
    

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(details: .constant(dev.michael))
            .environmentObject(PremiumViewModel(dev.michael.id!))
    }
}

//    var premiumSection: some View {
//        Section {
//            Button{
//                if !premium.hasPremium {
//                    showMembership = true
//                }
//            } label: {
//                VStack {
//                    ToggleView("Invisivle Blending", value: $premium.settings.premium.invisbleBlending)
//                    ToggleView("Hide Age", value: $premium.settings.premium.hideAge)
//                }
//            }
//
//        } header: {
//            Text("Premium")
//        }.textCase(nil)
//            .disabled(!premium.hasPremium)
//    }

