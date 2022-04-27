//
//  Propertiess.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI



enum Detail: String, CaseIterable, Identifiable {
    var id:String {self.rawValue}
    case name = "Name"
    case birthday = "Age"
    case gender = "I am"
    case parent = "Parental"
    case numberKids = "# of Children"
    case kidsRange = "Age Range"
    case location = "Location"
    case bio = "About"
    case photos = "Photos"
    case height = "Height"
    case relationship = "Relationship Staus"
    case wantKids = "Family Plans"
    case work = "Job Title"
    case education = "Education"
    case mobility = "Mobility"
    case religion = "Religion"
    case politics = "Politics"
    case ethnicity = "Ethnicity"
    case vices = "Vices"
    case interests = "Interests"

    var title: String {
        switch self {
        case .name:
            return "What is your name?"
        case .gender:
            return "I identify as"
        case .birthday:
            return "When is your birthday?"
        case .parent:
            return "Do you have children?"
        case .numberKids:
            return "How many children do you have?"
        case .kidsRange:
            return "What is the age range of your children?"
        case .wantKids:
            return "Do you want more children?"
        case .height:
            return "How tall are you?"
        case .photos:
            return "Add Photos"
        default:
            return self.rawValue
        }
    }
    
    var position: Position {
        
        switch self {
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
        default:
            return .center
        }

    }
    
    var imagePosition: Position {
        
        switch self {
            case .name: return .bottom
            case .birthday: return .top
            case .gender: return .top
            case .parent: return .top
            case .numberKids: return .top
            case .kidsRange: return .top
            case .location: return .bottom
            case .bio: return .bottom
            case .photos: return .bottom
            case .height: return .bottom
            case .relationship: return .top
            case .wantKids: return .top
            case .work: return .bottom
            case .education: return .bottom
            case .mobility: return .bottom
            case .religion: return .bottom
            case .politics: return .bottom
            case .ethnicity: return .bottom
            case .vices: return .bottom
            case .interests: return .bottom
        }

    }
    
    var svgName: String? {
        switch self {
        case .name:
            return "Family"
        case .birthday:
            return "Birthday"
        case .gender:
            return "Gender"
        case .parent, .numberKids, .kidsRange, .wantKids:
            return "Family"
        case .relationship:
            return "Relationship"
        case .work:
            return "Work"
        case .education:
            return "Education"
        case .mobility:
            return "Mobility"
        case .religion:
            return "Religion"
        case .politics:
            return "Politics"
        case .ethnicity:
            return "Ethnicity"
        default:
            return nil
        }
    }

    
    @ViewBuilder
    func getDestination(_ details: Binding<UserDetails>) -> some View {
        switch self {
        case .name:
            NameView(firstname: details.firstname, lastname: details.lastname)
        case .birthday:
            BirthdayView(birthday: details.birthday)
        case .gender:
            GenderView(gender: details.gender)
        case .parent:
            ParentView(isParent: details.isParent)
        case .numberKids:
            if details.isParent.wrappedValue {
                NumberKidsView(children: details.children)
            } else {
                LocationView(location: details.location)
            }
        case .kidsRange:
            if details.isParent.wrappedValue {
                KidsRangeView(childrenRange: details.childrenRange)
            } else {
                LocationView(location: details.location)
            }
            
        case .location:
            LocationView(location: details.location)
        case .bio:
            AboutView(about: details.bio)
        case .photos:
            AddPhotosView(photos: details.photos)
        case .height:
            HeightView(height: details.height)
        case .relationship:
            RelationshipView(relationship: details.relationship)
        case .wantKids:
            WantKidsView(wantKids: details.familyPlans)
        case .work:
            WorkView(workTitle: details.workTitle)
        case .education:
            EducationView(schoolTitle: details.schoolTitle)
        case .mobility:
            MobilityView(mobility: details.mobility)
        case .religion:
            ReligionView(religion: details.religion)
        case .politics:
            PoliticsView(politics: details.politics)
        case .ethnicity:
            EthnicityView(ethnicity: details.ethnicity)
        case .vices:
            VicesView(vices: details.vices)
        case .interests:
            InterestsView(interests: details.interests)
        }
    }
}

extension Detail {
    func next(_ isParent: Bool) -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        if self == .parent {
            if !isParent {
                return .location
            }
        }
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

enum Yes: String, Property {
    var title: String {self.rawValue}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.name}

    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        
    }
    
    var id: String { self.title }
    case yes = "Yes"
    case no = "No"
    case open = "Open to all"
}
