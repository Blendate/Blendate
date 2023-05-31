//
//  FiltersView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var model: UserViewModel
    @Environment(\.dismiss) private var pop
    
    var body: some View {
        NavigationStack {
            List {
                personal
                family
                background
                premium
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: dismiss)
                        .fontWeight(.semibold)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Filters")
        }
    }
    
    func dismiss(){ pop() }
}

extension FiltersView {
    
    func header(_ title: String, systemImage: String) -> some View {
        Label(title, systemImage: systemImage)
            .foregroundColor(.DarkBlue)
            .fontWeight(.semibold)
    }
    
    @ViewBuilder
    var personal: some View {
        Section {
            Location.Cell(distance: $model.user.filters.maxDistance)
            RangeCell(ageRange: $model.user.filters.ageRange, range: AgeRange.range)
            DetailCell($model.user.filters.seeking, isFilter: true)
        } header: {
            header("Personal", systemImage: "person.fill")
        }
    }
    
    @ViewBuilder
    var family: some View {
        Section {
            DetailCell($model.user.filters.isParent, isFilter: true)
            if model.user.filters.isParent == .yes {
                DetailCell($model.user.filters.maxChildrenn, isFilter: true)
            }
            DetailCell($model.user.filters.familyPlans, isFilter: true)
            DetailCell($model.user.filters.mobility, isFilter: true)

        } header: {
            header("Family", systemImage: "figure.2.and.child.holdinghands")

        }
    }
    
    @ViewBuilder
    var background: some View {
        Section {
            DetailCell($model.user.filters.relationship, isFilter: true)
            DetailCell($model.user.filters.religion, isFilter: true)
            DetailCell($model.user.filters.politics, isFilter: true)
        } header: {
            header("Background", systemImage: "house")

        }
    }
    
    @ViewBuilder
    var premium: some View {
        Section {
            RangeCell(ageRange: $model.user.filters.childrenRange, range: KidAgeRange.range)
            DetailCell($model.user.filters.minHeight, isFilter: true)
            DetailCell("Vices", systemImage: Vices.systemImage, value: nil) {
                
            }
            DetailCell("Interests", systemImage: Vices.systemImage, value: nil) {

            }
        } header: {
            header("Premium", systemImage: "lock")

        }
        .disabled(!storeManager.hasMembership)
    }
}


struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
            .environmentObject(session)
    }
}
