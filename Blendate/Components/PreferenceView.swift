////
////  PreferenceView.swift
////  Blendate
////
////  Created by Michael on 6/10/21.
////
//
//import SwiftUI
//
//enum PreferenceType: String {
//    case Name
//    case Birthday
//    case Gender
//    case Parent
//    case Kids
//    case KidsRange
//    case Location
//    case About
//    case Photos
//    case Height
//    case Interested
//    case Status
//    case WantsKids = "Family"
//    case Work
//    case Education
//    case Mobility
//    case Religion
//    case Politics
//    case Ethnicity
//    case Vices
//    case Interests
//    case Pref
////    case Test
//}
//
//struct PreferenceView<Content: View>: View {
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @EnvironmentObject var session: Session
//
//    let content: Content
//    let signup: Bool
//    let type: PreferenceType
//    let isParent: Bool
////    let direction: Direction
////    @Binding var active: Bool
//    @State var next: Bool = false
//
//    
//    init(
//        _ signup: Bool,
//         viewType: PreferenceType,
//         active: Binding<Bool>,
//         @ViewBuilder content: () -> Content) {
//        
//        self.content = content()
//        self.signup = signup
////        self._active = active
//        self.type = viewType
//        self.isParent = false
//    }
//    
//
//    
//    init(//_ user: Binding<User>,
//        _ signup: Bool,
//         viewType: PreferenceType,
//         active: Binding<Bool>,
//         _ isParent:Bool = true,
//         @ViewBuilder content: () -> Content) {
//        
//        self.content = content()
//        self.signup = signup
////        self._active = active
//        self.type = viewType
//        self.isParent = isParent
//    }
//    
//    var backButton: some View {
//        Button(action: {
//            self.mode.wrappedValue.dismiss()
//        }) {
//            Image(systemName: signup ? "chevron.left":"xmark")
//                .padding([.vertical, .trailing])
//                .foregroundColor(isTop() ? .white:.DarkBlue)
//        }
//    }
//    
//    func pushNext(){
//        if type == .Pref{
//            
//        } else {
//            next.toggle()
//        }
//    }
//    
//    var body: some View {
//        VStack {
//            if type != .Parent {
//                navBar
//            }
//            content
//        }
//        .circleBackground(imageName: imageName(), isTop: isTop())
//    }
//    
//    var navBar: some View {
//        HStack {
//            backButton
//            Spacer()
//            NavigationLink(
//                destination: nextView,
//                isActive: $next,
//                label: {
//                    Button(action: {
//                        next.toggle()
//                    }, label: {
//                        Text("Next")
//                            .font(.custom("Montserrat-Bold", size: 16))
//                            .foregroundColor(isTop() ? .white:.DarkBlue)
//                    })
//                }
//            ).disabled(!isActive())
//        }.padding(.horizontal)
//    }
//    
//    func imageName()->String{
//        return type.rawValue
//    }
//    
//    var nextView: some View {
//        switch type {
//        case .Name:
//            return AnyView(BirthdayView(signup))
//        case .Birthday:
//            return AnyView(GenderView(signup))
//        case .Gender:
//            return AnyView(ParentView(signup))
//        case .Parent:
//            if isParent {
//                return AnyView(NumberKidsView(signup))
//            } else {
//                return AnyView(LocationView(signup))
//            }
//        case .Kids:
//            return AnyView(KidsRangeView(signup))
//        case .KidsRange:
//            return AnyView(LocationView(signup))
//        case .Location:
//            return AnyView(AboutView(signup))
//        case .About:
//            return AnyView(AddPhotosView(signup))
//        case .Photos:
//            return AnyView(MorePreferencesView())
//        case .Height:
//            return AnyView(InterestedView(signup))
//        case .Interested:
//            return AnyView(RelationshipView(signup))
//        case .Status:
//            return AnyView(WantKidsView(signup))
//        case .WantsKids:
//            return AnyView(WorkView(signup))
//        case .Work:
//            return AnyView(EducationView(signup))
//        case .Education:
//            return AnyView(MobilityView(signup))
//        case .Mobility:
//            return AnyView(ReligionView(signup))
//        case .Religion:
//            return AnyView(PoliticsView(signup))
//        case .Politics:
//            return AnyView(EthnicityView(signup))
//        case .Ethnicity:
//            return AnyView(VicesView(signup))
//        case .Vices:
//            return AnyView(AboutView(signup))
//        case .Interests:
//            return AnyView(AboutView(signup))
//        case .Pref:
//            return AnyView(HeightView())
//
//        }
//    }
//    
//    func isTop()->Bool{
//        switch type {
//        case .Name:
//            return true
//        case .Birthday:
//            return false
//        case .Gender:
//            return true
//        case .Parent:
//            return true
//        case .Kids:
//            return true
//        case .KidsRange:
//            return true
//        case .Location:
//            return false
//        case .About:
//            return true
//        case .Photos:
//            return false
//        case .Height:
//            return true
//        case .Interested:
//            return false
//        case .Status:
//            return false
//        case .WantsKids:
//            return true
//        case .Work:
//            return false
//        case .Education:
//            return false
//        case .Mobility:
//            return false
//        case .Religion:
//            return true
//        case .Politics:
//            return false
//        case .Ethnicity:
//            return false
//        case .Vices:
//            return true
//        case .Interests:
//            return true
//        case .Pref:
//            return true
//        }
//    }
//    
//    func isActive()->Bool{
//        switch type {
//        case .Name:
//            return !(session.user.firstName.isEmpty || session.user.lastName.isEmpty)
//        case .Birthday:
//            return true //session.user.birthday != Date()
//        case .Gender:
//            print(session.user.gender)
//            return session.user.gender != .none
//        case .Parent:
//            return true
//        case .Kids:
//            return true
//        case .KidsRange:
//            return true
//        case .Location:
//            return false
//        case .About:
//            return true
//        case .Photos:
//            return false
//        case .Height:
//            return true
//        case .Interested:
//            return false
//        case .Status:
//            return false
//        case .WantsKids:
//            return true
//        case .Work:
//            return false
//        case .Education:
//            return false
//        case .Mobility:
//            return false
//        case .Religion:
//            return true
//        case .Politics:
//            return false
//        case .Ethnicity:
//            return false
//        case .Vices:
//            return true
//        case .Interests:
//            return true
//        case .Pref:
//            return true
//        }
//    }
//}
//
////
////switch type {
////case .Name:
////    return ""
////case .Birthday:
////    return ""
////case .Gender:
////    return ""
////case .Parent:
////    return ""
////case .Kids:
////    return ""
////case .KidsRange:
////    return ""
////case .Location:
////    return ""
////case .About:
////    return ""
////case .Photos:
////    return ""
////case .Height:
////    return ""
////case .Interested:
////    return ""
////case .WantsKids:
////    return ""
////case .Work:
////    return ""
////case .Education:
////    return ""
////case .Mobility:
////    return ""
////case .Religion:
////    return ""
////case .Politics:
////    return ""
////case .Ethnicity:
////    return ""
////case .Vices:
////    return ""
////case .Interests:
////    return ""
////case .Pref:
////    return ""
////}
//
