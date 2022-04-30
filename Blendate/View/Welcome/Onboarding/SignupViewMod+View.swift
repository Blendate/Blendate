//
//  SignupViewMod+View.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI

extension SignupViewMod {
    
    struct SignupTitle: View {
        let detail: Detail
        let imagePosition: Position
    
        init(_ detail: Detail, _ position: Position){
            self.detail = detail
            self.imagePosition = position
        }
    
        var body: some View {
            Text(detail.title)
                .fontType(.semibold, 32, .DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
    
    
    var nextLabel: some View {
        let string: String
        switch type {
        case .height, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics, .ethnicity, .vices:
            string = valueValid ? "Next":"Skip"
        case .interests:
            string = ""
        default:
            string = "Next"

        }
        
        return Text(string)
            .fontWeight(.bold)
            .tint(imagePosition == .top ? .white:.Blue)

    }
    
    var next: Detail {
        let all = Detail.allCases
        let idx = all.firstIndex(of: type)!
        if type == .isParent {
            if !details.info.isParent {
                return .location
            }
        }
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
    
    var imageBubble: some View {
        ZStack(alignment: .center) {
            Image(imagePosition == .top ? "Ellipse_Top":"Ellipse_Bottom")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                .edgesIgnoringSafeArea(.vertical)
            if let imageString = svgName {
                Image(imageString)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 270, height: 226 , alignment: .center)
            } else {
                EmptyView()
            }
        }
    }
}

extension SignupViewMod {
    
    var valueValid: Bool {
        switch type {
        case .name: return (details.firstname.count > 2) && !details.firstname.isBlank
        case .birthday: return details.age >= 18
        case .gender: return !details.gender.isEmpty
        case .isParent: return true
        case .children: return details.info.children > 0
        case .childrenRange: return details.info.childrenRange.max != 0
        case .location: return !details.info.location.name.isBlank
        case .bio: return !details.bio.isBlank
        case .photos: return !details.photos.isEmpty
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
    
    var position: Position {
        switch type {
        case .name: return .top
        case .birthday: return .bottom
        case .location: return .top
        case .bio: return .top
        case .photos: return .top
        case .height: return .top
        case .work: return .top
        case .education: return .top
        case .religion: return .top
        case .ethnicity: return .top
        case .vices: return .top
        case .interests: return .top
        default: return .center
        }

    }
    
    var imagePosition: Position {
        
        switch type {
        case .name: return .bottom
        case .birthday: return .top
        case .gender: return .top
        case .isParent: return .top
        case .children: return .top
        case .childrenRange: return .top
        case .location: return .bottom
        case .bio: return .bottom
        case .photos: return .bottom
        case .height: return .bottom
        case .relationship: return .top
        case .familyPlans: return .top
        case .work: return .bottom
        case .education: return .bottom
        case .mobility: return .bottom
        case .religion: return .bottom
        case .politics: return .bottom
        case .ethnicity: return .bottom
        case .vices: return .bottom
        case .interests: return .bottom
        default: return .bottom
        }

    }
    
    var svgName: String? {
        switch type {
        case .name: return "Family"
        case .birthday: return "Birthday"
        case .gender: return "Gender"
        case .isParent, .children, .childrenRange, .familyPlans: return "Family"
        case .relationship: return "Relationship"
        case .work: return "Work"
        case .education: return "Education"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        default:
            return nil
        }
    }

    @ViewBuilder
    func getDestination() -> some View {
        switch type {
        case .name:
            NameView(firstname: $details.firstname, lastname: $details.lastname)
        case .birthday:
            BirthdayView(birthday: $details.birthday)
        case .gender:
            GenderView(gender: $details.gender)
        case .isParent:
            ParentView(isParent: $details.info.isParent)
        case .children:
            if $details.info.isParent.wrappedValue {
                NumberKidsView(children: $details.info.children)
            } else {
                LocationView(location: $details.info.location)
            }
        case .childrenRange:
            if $details.info.isParent.wrappedValue {
                KidsRangeView(childrenRange: $details.info.childrenRange)
            } else {
                LocationView(location: $details.info.location)
            }
            
        case .location:
            LocationView(location: $details.info.location)
        case .bio:
            AboutView(about: $details.bio)
        case .photos:
            AddPhotosView(photos: $details.photos, signup: true)
        case .height:
            HeightView(height: $details.info.height)
        case .relationship:
            RelationshipView(relationship: $details.info.relationship)
        case .familyPlans:
            WantKidsView(wantKids: $details.info.familyPlans)
        case .work:
            WorkView(workTitle: $details.workTitle)
        case .education:
            EducationView(schoolTitle: $details.schoolTitle)
        case .mobility:
            MobilityView(mobility: $details.info.mobility)
        case .religion:
            ReligionView(religion: $details.info.religion)
        case .politics:
            PoliticsView(politics: $details.info.politics)
        case .ethnicity:
            EthnicityView(ethnicity: $details.info.ethnicity)
        case .vices:
            VicesView(vices: $details.info.vices)
        case .interests:
            InterestsView(interests: $details.interests)
        default: EmptyView()
        }
    }

}
