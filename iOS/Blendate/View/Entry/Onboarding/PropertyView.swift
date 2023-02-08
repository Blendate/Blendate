//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct PropertyView: View {
    @EnvironmentObject var session: SessionViewModel
    @Environment(\.dismiss) private var dismiss
    let detail: Detail
    var signup: Bool = false
    var isFilter: Bool = false
    var next: Detail {
        detail.next(isParent: session.user.info.isParent)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SignupTitle(detail, isFilter)
            DetailView
            Spacer()
        }
            .background(detail: detail)
            .ignoresSafeArea(.keyboard)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if signup {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if detail == .interests {
                            startButton
                        } else {
                            nextButton
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension PropertyView {
        
    @ViewBuilder
    var nextButton: some View {
        let label = Stats.Required.contains(detail) ? "Next" : (valueValid ? "Next":"Skip")
        NavigationLink {
            PropertyView(detail: next, signup: signup)
        } label: {
            Text(label)
                .fontWeight(.bold)
                .tint(.Blue)
        }.disabled((!valueValid && detail.required) || detail == .interests)
    }
    
    @ViewBuilder
    var startButton: some View {
        Button {
            
        } label: {
            Text("Start Blending")
                .fontWeight(.bold)
                .tint(.Blue)
        }

    }
    
//    @MainActor
//    func createUserDoc() throws {
//        try create(user)
//
//        let settingsService = FirestoreService<User.Settings>(collection: Self.Settings)
//        try settingsService.create( User.Settings(id: user.id) )
//        loadingState = .user
//    }

}


extension PropertyView {
    
    struct Textfield: View {
        @Binding var string: String
        var body: some View {
            TextField("", text: $string)
                    .fontType(.semibold, 22)
                    .padding(.horizontal, 40)
                    .foregroundColor(.DarkBlue)
                    .textFieldStyle(.roundedBorder)
                    .shadow(radius: 2)
        }
    }
    
    var valueValid: Bool {
        let details = session.user
        switch detail {
        case .name: return (details.firstname.count > 2) && !details.firstname.isBlank
        case .birthday: return details.birthday.age >= 18
        case .gender: return !details.gender.isEmpty
        case .isParent: return true
        case .children: return details.info.children > 0
        case .childrenRange: return details.info.childrenRange.max != 0
        case .location: return !details.info.location.name.isBlank
        case .bio: return !details.bio.isBlank
        case .photos: return details.photos.count > 2
        case .interests: return false
        case .height: return details.info.height != 0
        case .relationship: return !details.info.relationship.isBlank
        case .familyPlans: return !details.info.familyPlans.isBlank
        case .work: return !details.workTitle.isBlank
        case .education: return !details.schoolTitle.isBlank
        case .mobility: return !details.info.mobility.isBlank
        case .religion: return !details.info.religion.isBlank
        case .politics: return !details.info.politics.isBlank
        case .ethnicity: return !details.info.ethnicity.isBlank
        case .vices: return !details.info.vices.isEmpty
        default: return true
        }
    }

    @ViewBuilder
    var DetailView: some View {
        let details = $session.user
        let filters = $session.user.filters
        let valueType: Binding<Stats> = isFilter ? $session.user.filters : $session.user.info

        switch detail {
        case .name:
            NameView(firstname: details.firstname, lastname: details.lastname)
        case .birthday:
            DatePicker(selection: details.birthday, in: ...Date.youngestBirthday, displayedComponents: [.date]) {}
                .datePickerStyle(.graphical)
                .tint(.Blue)
        case .gender:
            OptionGridView<Gender, String>(details.gender)
        case .isParent:
            ParentView(isParent: valueType.isParent)
        case .children:
            if details.info.isParent.wrappedValue {
                AgeRangeView(value: details.info.children, type: .age, pickerCount: 7)
                    .padding(.top)
            } else {
                LocationView(location: details.info.location, maxDistance: filters.maxDistance)
            }
        case .childrenRange:
            if details.info.isParent.wrappedValue {
                KidsRangeView(childrenRange: details.info.childrenRange)
            } else {
                LocationView(location: details.info.location, maxDistance: filters.maxDistance)
            }
            
        case .location:
            LocationView(location: details.info.location, maxDistance: filters.maxDistance)
        case .seeking:
            OptionGridView<Gender, String>(valueType.seeking)
        case .bio:
            AboutView(about: details.bio)
        case .photos:
            AddPhotosView(photos: details.photos, signup: true)
        case .height:
            HeightView(height: valueType.height, isFilter: isFilter)
        case .relationship:
            OptionGridView<Relationship, String>(valueType.relationship)
        case .familyPlans:
            OptionGridView<FamilyPlans, String>(valueType.familyPlans)
        case .work:
            Textfield(string: details.workTitle)
        case .education:
            VStack {
                Text("What University, College, or High School did you attend?")
                    .fontType(.regular, 16, .DarkBlue)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Textfield(string: details.schoolTitle)
            }
            
//            EducationView(schoolTitle: details.schoolTitle, isFilter: isFilter)
        case .mobility:
            OptionGridView<Mobility, String>(valueType.mobility)
        case .religion:
            ScrollView(.vertical) {
                OptionGridView<Religion, String>(valueType.religion)
            }
        case .politics:
            OptionGridView<Politics, String>(valueType.politics)
        case .ethnicity:
            ScrollView(.vertical) {
                OptionGridView<Ethnicity, String>(valueType.ethnicity)
            }
        case .vices:
            ScrollView(.vertical) {
                OptionGridView<Vices, [String]>(valueType.vices)
            }
        case .interests:
            InterestsView(interests: details.interests, isFilter: isFilter, isSignup: signup)

        case .maxDistance:
            LocationView(location: details.info.location, maxDistance: filters.maxDistance)
        case .ageRange:
            Text(details.info.ageRange.wrappedValue.label(min: KAgeRange.min, max: KAgeRange.max))
        }
    }
}


extension PropertyView {
    
    struct SignupTitle: View {
        let detail: Detail
        let isFilter: Bool
        
        init(_ detail: Detail, _ isFilter: Bool){
            self.detail = detail; self.isFilter = isFilter
        }

        var body: some View {
            if let title {
                Text(title)
                    .fontType(.semibold, 32, .DarkBlue)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                    .padding(.horizontal)
            }
        }
        
        var title: String? {
            switch detail {
            case .name, .bio, .photos: return nil
            case .gender: return isFilter ? "Seeking" : "I identify as"
            case .work: return "Job Title"
            case .isParent: return isFilter ? "Are they a parent?" : "Do you have children?"
            case .children: return isFilter ? "How many children?" : "How many children do you have?"
            case .childrenRange: return "Children's age range"
            case .height: return isFilter ? "Height Requirement" : "How tall are you?"
            case .relationship: return "Relationship Staus"
            case .familyPlans: return "Family Plans"
            case .maxDistance: return "Max Distance"
            case .ageRange: return "Age Range"
            default: return detail.rawValue.capitalized
            }
        }
    }
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PropertyView(detail: .seeking, signup: true)
                .environmentObject(SessionViewModel(user: dev.michael))

        }
    }
}