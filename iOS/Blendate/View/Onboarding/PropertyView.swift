//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

enum Position {
    case top
    case bottom
    case center
}

struct PropertyView: View {
    @EnvironmentObject var session: SessionViewModel
    @Environment(\.dismiss) private var dismiss
    let detail: Detail
    let signup: Bool
    let type: PropType
    
    init(_ detail: Detail, signup: Bool = false, propType: PropType = .detail){
        self.detail = detail
        self.signup = signup
        self.type = propType
    }
    
    var body: some View {
            ZStack {
                imageBubble
                VStack(spacing: 0) {
                    getDestination()
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if signup {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            PropertyView(next, signup: signup)
                        } label: {
                            nextLabel
                        }.disabled((!valueValid && detail.required) || detail == .interests)
                    }
                }

            }
            .navigationViewStyle(StackNavigationViewStyle())

    }
}

extension PropertyView {
        
    var nextLabel: some View {
        let string: String
        switch detail {
        case .height, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics, .ethnicity, .vices:
            string = valueValid ? "Next":"Skip"
        case .interests:
            string = ""
        default:
            string = "Next"

        }
        
        return Text(string)
            .fontWeight(.bold)
            .tint(.Blue)

    }
    
    var next: Detail {
        let all = Detail.allCases
        let idx = all.firstIndex(of: detail)!
        if detail == .isParent {
            if !session.user.info.isParent {
                return .location
            }
        }
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
    
    var imageBubble: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack(alignment: .center) {
                Image("Ellipse_Bottom")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                    .edgesIgnoringSafeArea(.vertical)
                if let imageString = detail.svgName {
                    Image(imageString)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 270, height: 226 , alignment: .center)
                }
            }
        }
        .edgesIgnoringSafeArea(signup ? .bottom : .leading)
    }
}

extension PropertyView {
    
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
    func getDestination() -> some View {
        let details = $session.user
        let filters = $session.user.filters
        let isFilter = type == .filter
        let valueType: Binding<Stats> = type == .filter ? $session.user.filters : $session.user.info

        switch detail {
        case .name:
            NameView(firstname: details.firstname, lastname: details.lastname)
        case .birthday:
            BirthdayView(birthday: details.birthday)
        case .gender:
            GenderView(gender: details.gender, detail: Detail.gender, isFilter: isFilter)
        case .isParent:
            ParentView(isParent: valueType.isParent, isFilter: isFilter)
        case .children:
            if details.info.isParent.wrappedValue {
                NumberKidsView(children: details.info.children, isFilter: isFilter)
            } else {
                LocationView(location: details.info.location, maxDistance: filters.maxDistance)
            }
        case .childrenRange:
            if details.info.isParent.wrappedValue {
                KidsRangeView(childrenRange: details.info.childrenRange, isFilter: isFilter)
            } else {
                LocationView(location: details.info.location, maxDistance: filters.maxDistance)
            }
            
        case .location:
            LocationView(location: details.info.location, maxDistance: filters.maxDistance)
        case .bio:
            AboutView(about: details.bio)
        case .photos:
            AddPhotosView(photos: details.photos, signup: true)
        case .height:
            HeightView(height: valueType.height, isFilter: isFilter)
        case .relationship:
            RelationshipView(relationship: valueType.relationship, isFilter: isFilter)
        case .familyPlans:
            WantKidsView(wantKids: valueType.familyPlans, isFilter: isFilter)
        case .work:
            WorkView(workTitle: details.workTitle, isFilter: isFilter)
        case .education:
            EducationView(schoolTitle: details.schoolTitle, isFilter: isFilter)
        case .mobility:
            MobilityView(mobility: valueType.mobility, isFilter: isFilter)
        case .religion:
            ReligionView(religion: valueType.religion, isFilter: isFilter)
        case .politics:
            PoliticsView(politics: valueType.politics, isFilter: isFilter)
        case .ethnicity:
            EthnicityView(ethnicity: valueType.ethnicity, isFilter: isFilter)
        case .vices:
            VicesView(vices: valueType.vices, isFilter: isFilter)
        case .interests:
            InterestsView(interests: details.interests, isFilter: isFilter)
        case .seeking:
            GenderView(gender: valueType.seeking, detail: Detail.seeking, isFilter: isFilter)
        case .maxDistance:
            LocationView(location: details.info.location, maxDistance: filters.maxDistance)
        case .ageRange:
            Text(details.info.ageRange.wrappedValue.label(max: 70))
        }
    }
}


