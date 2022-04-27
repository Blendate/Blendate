//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var user: User
    
    init(user: Binding<User>) {
        self._user = user
        ColorNavbar()
    }
    
    var heightProxy: Binding<Double>{Binding<Double>(
        get: { return Double(user.filters.minHeight) },
        set: { user.filters.minHeight = Int($0) })
    }
    
    var distanceProxy: Binding<Double>{Binding<Double>(
        get: { return Double(user.filters.maxDistance) },
        set: { user.filters.maxDistance = Int($0) })
    }
    @State var drinking: String = "Open to all"
    @State var smoking: String = "Open to all"
    @State var cannabis: String = "Open to all"

    var body: some View {
        NavigationView{
            List {
                PreferenceCell(("Age Range \(user.filters.ageRange.min) - \(user.filters.ageRange.max)"), true) {
                    RangeSliderView(title: "", min: $user.filters.ageRange.min, max: $user.filters.ageRange.max)
                }
                PreferenceCell("Max Distance: \(user.filters.maxDistance) miles", true){
                    Slider(value: distanceProxy, in: 1...50, step: 1.0).accentColor(.Blue)
                }
                PreferenceCell("Ethnicity") {
                    PropPicker(prop: Ethnicity.none, value: $user.filters.ethnicity)
                }
                PreferenceCell("Religion") {
                    PropPicker(prop: Religion.none, value: $user.filters.religion)
                }
                PreferenceCell("Family Plans") {
                    PropPicker(prop: FamilyPlans.none, value: $user.filters.familyPlans)
                }
                PreferenceCell("Politics") {
                    PropPicker(prop: Politics.none, value: $user.filters.politics)
                }
                Section(header: PremiumHeader(user: $user)) {
                    Group {
                        PreferenceCell("Min Height \(heightSting())", true) {
                            Slider(value: heightProxy, in: 58...84, step: 1.0).accentColor(.Blue)
                        }
                        vices
                    }.disabled(!user.settings.premium)
                }
            }
            .listStyle(.insetGrouped)
            .pickerStyle(MenuPickerStyle())
            .background(Color.LightGray)
            .navigationBarTitle("Filters")
        }
    }
    
    private func heightSting()->String{
        let feet = Measurement(value: Double(user.filters.minHeight), unit: UnitLength.inches).converted(to: .feet).heightOnFeetsAndInches
        
        return feet ?? "--"
    }
    
    
    struct PropPicker<T:Property>: View {
        let prop: T
        @Binding var value: String
        
        var body: some View {
            Picker("", selection: $value) {
                ForEach(Array(T.allCases), id: \.self.value) {
                    Text($0.value)
                        .tag($0.value)
                }
            }
        }
    }
    
    var vices: some View {
        Group {
            PreferenceCell("Drinking") {
                Picker("", selection: $drinking) {
                    ForEach(Yes.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
            PreferenceCell("Smoking") {
                Picker("", selection: $drinking) {
                    ForEach(Yes.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
            PreferenceCell("Cannabis") {
                Picker("", selection: $drinking) {
                    ForEach(Yes.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
        }
    }
}

struct PreferenceCell<Content: View>: View {
    let title: String
    var content: Content
    let isSlider: Bool
    
    init(_ title: String, _ isSlider: Bool = false, @ViewBuilder content: () -> Content){
        self.title = title
        self.content = content()
        self.isSlider = isSlider
    }
    
    var body: some View {
        
        Group {
            if isSlider {
                VStack {
                    HStack {
                        Text(title)
                            .fontType(.semibold, 16, .DarkBlue)
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    content
                }
            } else {
                HStack {
                    VStack {
                        Text(title)
                            .fontType(.semibold, 16, .DarkBlue)
                            .padding(.vertical, 15)
                    }
                    Spacer()
                    content
                        .accentColor(.Blue)
                }
            }
        }.listRowBackground(Color.white)
    }
}


struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(user: .constant(dev.emptyUser))
    }
}
