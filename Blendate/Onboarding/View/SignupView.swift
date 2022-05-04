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

struct SignupViewContainer: View {
    var body: some View {
        NavigationView {
            SignupView(.name)
        }
    }
}


struct SignupView: View {
    @EnvironmentObject var session: SessionViewModel
    let type: SignupDetail
    
    init(_ type: SignupDetail){
        self.type = type
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SignupView(next)
                    } label: {
                        nextLabel
                    }.disabled((!valueValid && type.required) || type == .interests)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())

    }
}

extension SignupView {
        
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
            .tint(.Blue)

    }
    
    var next: SignupDetail {
        let all = SignupDetail.allCases
        let idx = all.firstIndex(of: type)!
        if type == .isParent {
            if !session.user.details.info.isParent {
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
                if let imageString = type.svgName {
                    Image(imageString)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 270, height: 226 , alignment: .center)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension SignupView {
    
    var valueValid: Bool {
        let details = session.user.details
        switch type {
        case .name: return (details.firstname.count > 2) && !details.firstname.isBlank
        case .birthday: return details.age >= 18
        case .gender: return !details.gender.isEmpty
        case .isParent: return true
        case .children: return details.info.children > 0
        case .childrenRange: return details.info.childrenRange.max != 0
        case .location: return !details.info.location.name.isBlank
        case .bio: return !details.bio.isBlank
        case .photos: return details.photos[0].url != nil && details.photos[1].url != nil
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
        let details = $session.user.details
        switch type {
        case .name:
            NameView(firstname: details.firstname, lastname: details.lastname)
        case .birthday:
            BirthdayView(birthday: details.birthday)
        case .gender:
            GenderView(gender: details.gender, detail: .gender)
        case .isParent:
            ParentView(isParent: details.info.isParent)
        case .children:
            if details.info.isParent.wrappedValue {
                NumberKidsView(children: details.info.children)
            } else {
                LocationView(location: details.info.location)
            }
        case .childrenRange:
            if details.info.isParent.wrappedValue {
                KidsRangeView(childrenRange: details.info.childrenRange)
            } else {
                LocationView(location: details.info.location)
            }
            
        case .location:
            LocationView(location: details.info.location)
        case .bio:
            AboutView(about: details.bio)
        case .photos:
            AddPhotosView(photos: details.photos, signup: true)
        case .height:
            HeightView(height: details.info.height)
        case .relationship:
            RelationshipView(relationship: details.info.relationship)
        case .familyPlans:
            WantKidsView(wantKids: details.info.familyPlans)
        case .work:
            WorkView(workTitle: details.workTitle)
        case .education:
            EducationView(schoolTitle: details.schoolTitle)
        case .mobility:
            MobilityView(mobility: details.info.mobility)
        case .religion:
            ReligionView(religion: details.info.religion)
        case .politics:
            PoliticsView(politics: details.info.politics)
        case .ethnicity:
            EthnicityView(ethnicity: details.info.ethnicity)
        case .vices:
            VicesView(vices: details.info.vices)
        case .interests:
            InterestsView(interests: details.interests)
        case .seeking:
            GenderView(gender: details.info.seeking, detail: .seeking)
        }
    }
}


