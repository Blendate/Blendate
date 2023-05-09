//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//


import SwiftUI

//struct PropView<Content:View>: View {
//    var title: String?
//    var svg: String?
//    
//    @ViewBuilder var content: Content
//    
//    var body: some View {
//        VStack {
//            if let title {
//                Text(title)
//                    .font(.title.weight(.semibold), .DarkBlue)
//                    .multilineTextAlignment(.center)
//                    .padding(.vertical)
//                    .padding(.horizontal)
//            }
//            content
//            Spacer()
//        }
//        .background(svg: svg)
//    }
//}

//struct SignupView: View {
//    @EnvironmentObject var navigation: NavigationManager
//    @State private var path = NavigationPath()
//
//    let uid: String
//    var body: some View {
//        NavigationStack {
//            PropView(path: .name, signup: true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(systemName: "chevron.left") {
//                        navigation.signOut()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NextButton(current: .name)
//                }
//            }
//            .navigationDestination(for: SignupPath.self) { path in
//                PropView(path: path, signup: true)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        NextButton(current: path)
//                    }
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationViewStyle(StackNavigationViewStyle())
//
//        }
//    }
//
//
//    struct NextButton: View {
//        @EnvironmentObject var navigation: NavigationManager
//        @State private var error: ErrorAlert?
//        let current: SignupPath
//        var valueValid: Bool { navigation.user.valid(detail: current) }
//        var required: Bool { current.required }
//
//        var label: String { required ? "Next" : (valueValid ? "Next":"Skip") }
//
//        var next: SignupPath {
//            if current == .isParent, navigation.user.info.parent == Parent.no.rawValue {
//                return .location
//            }
//            let all = SignupPath.allCases
//            let idx = all.firstIndex(of: current)
//            let next = all.index(after: idx!)
//            return all[next == all.endIndex ? all.startIndex : next]
//        }
//
//
//        var body: some View {
//            if current == .mobility {
//                Button(action: createDoc) {
//                    Text("Start Blending")
//                        .fontWeight(.bold)
//                        .tint(.Blue)
//                }
//                .errorAlert(error: $error) { err in
//                    Button("Try Again", action: createDoc)
//                    Button("Cancel", role: .cancel) {}
//                }
//            } else {
//                NavigationLink(value: next) {
//                    Text(label)
//                        .fontWeight(.bold)
//                        .tint(.Blue)
//                }
//                .disabled((!valueValid && required))
//            }
//        }
//
//        private func createDoc() {
//            do {
//                try navigation.createDoc(with: uid)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//
//}
//
//struct PropView: View {
//    @EnvironmentObject var session: UserViewModel
//    let path: SignupPath
//    var signup: Bool = false
//    var isFilter: Bool = false
//
//    var body: some View {
//        VStack {
//            if let title = path.title(isFilter) {
//                Text(title)
//                    .font(.title.weight(.semibold), .DarkBlue)
//                    .multilineTextAlignment(.center)
//                    .padding(.vertical)
//                    .padding(.horizontal)
//            }
//            PropertyView(path: path, user: $session.user, uid: session.uid, isFilter: isFilter)
//            Spacer()
//        }
//        .background(svg: path.svg)
//    }
//}
//
//extension PropView {
//    struct DetailField: View {
//        @Binding var text: String
//        var body: some View {
//            TextField("", text: $text)
//            .padding()
//            .overlay(
//              RoundedRectangle(cornerRadius: 15)
//                .stroke(lineWidth: 2)
//                .foregroundColor(Color.Blue.opacity(0.5))
//            )
//            .font(.title)
//            .padding(.horizontal,32)
//        }
//    }
//}
//
//extension PropView {
//
//    struct PropertyView: View {
//        let path: SignupPath
//        @Binding var user: User
//        let uid: String
//        let isFilter: Bool
//
//        var isParent: Bool { user.info.isParent }
//
//        var body: some View {
//            let details = $user.details
//            let stats = isFilter ? $user.filters : $user.info
//
//            switch path {
//            case .name:
//                NameView(firstname: details.firstname, lastname: details.lastname)
//            case .birthday:
//                DatePicker(selection: details.birthday, in: ...Date.youngestBirthday, displayedComponents: [.date]) {}.datePickerStyle(.graphical).tint(.Blue)
//            case .gender:
//                OptionGridView<Gender>(chosen: stats.gender, isFilter: isFilter)
//            case .isParent:
//                OptionGridView<Parent>(chosen: stats.parent, isFilter: isFilter)
//            case .children:
//                AgeRangeView(value: stats.children, type: .age)
//            case .childrenRange:
//                KidsRangeView(childrenRange: stats.childrenRange)
//            case .location:
//                LocationView(location: details.location, maxDistance: stats.maxDistance)
//            case .seeking:
//                OptionGridView<Seeking>(chosen: stats.seeking, isFilter: false)/// set filter to false to show "Open" option,
//            case .about:
//                AboutView(about: details.bio)
//            case .photos:
//                AddPhotosView(uid: uid, photos: details.photos)
//            case .relationship:
//                OptionGridView<RelationshipStatus>(chosen: stats.relationship, isFilter: isFilter)
//            case .familyPlans:
//                OptionGridView<FamilyPlans>(chosen: stats.familyPlans, isFilter: isFilter)
//            case .work:
//                DetailField(text: details.workTitle)
//            case .education:
//                DetailField(text: details.schoolTitle)
//            case .religion:
//                OptionGridView<Religion>(chosen: stats.religion, isFilter: isFilter)
//            case .politics:
//                OptionGridView<Politics>(chosen: stats.politics, isFilter: isFilter)
////            case .ethnicity:
////                OptionGridView<Ethnicity>(chosen: stats.ethnicity, isFilter: isFilter)
//            case .mobility:
//                OptionGridView<Mobility>(chosen: stats.mobility, isFilter: isFilter)
//            case .height:
//                HeightView(height: stats.height, isFilter: isFilter)
//            case .vices:
//                OptionGridView<FamilyPlans>(chosen: stats.familyPlans, isFilter: isFilter)
//            case .interests:
//                OptionGridView<FamilyPlans>(chosen: stats.familyPlans, isFilter: isFilter)
//            default:
//                Text(path.title(isFilter) ?? "Path")
//            }
//        }
//    }
//}
