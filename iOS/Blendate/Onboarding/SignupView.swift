//
//  SignupView2.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/3/23.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appNavigation: NavigationManager
    @StateObject var model: SignupViewModel
    
    @State private var path: [Onboarding] = []
//    @State var user = User()
    
    var body: some View {
        NavigationStack(path: $path) {
            PropertyView(title: nil, svg: Name.svgImage) {
                Name.PropertyView(value: $model.name)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(systemName: "chevron.left") {
                        appNavigation.signOut()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NextButton(current: .name)
                        .environmentObject(model)
                }
            }
            .navigationDestination(for: Onboarding.self) { path in
                PropertyView(title: path.title, svg: path.svg) {
                    view(for: path)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NextButton(current: path)
                            .environmentObject(model)

                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())

        }
    }
    
    @ViewBuilder
    func view(for onboard: Onboarding) -> some View {
        switch onboard {
        case .name:
            Name.PropertyView(value: $model.name)
        case .birthday:
            Birthday.PropertyView(value: $model.birthday)
        case .gender:
            Gender.PropertyView(value: $model.gender)
        case .isParent:
            Parent.PropertyView(value: $model.isParent)
        case .children:
            Children.PropertyView(value: $model.children)
        case .childrenRange:
            KidAgeRange.PropertyView(value: $model.childrenRange)
        case .location:
            Location.LocationView(location: $model.location, maxDistance: $model.maxDistance)
        case .seeking:
            Gender.PropertyView(value: $model.seeking)
        case .about:
            Bio.PropertyView(value: $model.about)
        case .photos:
            AddPhotosView(uid: model.uid, photos: $model.photos)
        }
    }
}

extension SignupView {
    struct NextButton: View {
        @EnvironmentObject var navigation: NavigationManager
        @EnvironmentObject var model: SignupViewModel

        let current: Onboarding

        @State private var error: ErrorAlert?

        var body: some View {
            if current == .photos {
                Button(action: createDoc) {
                    Text("Start Blending")
                        .fontWeight(.bold)
                        .tint(.Blue)
                }
                .errorAlert(error: $error) { err in
                    Button("Try Again", action: createDoc)
                    Button("Cancel", role: .cancel) {}
                }
            } else {
                NavigationLink(value: next) {
                    Text("Next")
                        .fontWeight(.bold)
                        .tint(.Blue)
                }
                .disabled(disabled)
            }
        }
        
        var disabled: Bool { false }

        var next: Onboarding {
            if current == .isParent, !model.isParent.rawValue {
                return .location
            }
            let all = Onboarding.allCases
            let idx = all.firstIndex(of: current)
            let next = all.index(after: idx!)
            return all[next == all.endIndex ? all.startIndex : next]
        }

        private func createDoc() {
            do {
                let collection = FireStore.shared.firestore.collection(CollectionPath.Users)
                let user = User (
                    firstname: model.name.first,
                    lastname: model.name.last,
                    birthday: model.birthday.date,
                    gender: model.gender,
                    isParent: model.isParent,
                    children: model.children,
                    childrenRange: model.childrenRange,
                    bio: model.about,
                    location: model.location,
                    photos: model.photos,
                    filters: Filters(seeking: model.seeking)
                )
                try collection.document(model.uid).setData(from: user)
                navigation.state = .user(model.uid, user)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}




struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(model: .init(uid: aliceUID))
            .environmentObject(NavigationManager())
    }
}
