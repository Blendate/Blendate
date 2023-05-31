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
                Birthday.PropertyView(value: $model.birthday)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(systemName: "chevron.left") {
                        appNavigation.signOut()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NextButton(current: .birthday)
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
        var disabled: Bool {
            !model.valid(for: current)
        }

        @State private var error: ErrorAlert?

        var body: some View {
            if current == .photos {
                Button(action: createDoc) {
                    Text("Start Blending")
                        .fontWeight(.bold)
                        .tint(.Blue)
                }
                .disabled(disabled)
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
                let (uid, user, settings) = try model.createDoc()
                navigation.state = .user(uid, user, settings)
            } catch {
                self.error = SignupView.Error()
            }

        }
    }
    struct Error: ErrorAlert {
        var title: String = "Server Error"
        var message: String = "There was an error creating your account, if the problem persists contact support"
    }
}




struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(model: .init(uid: aliceUID))
            .environmentObject(NavigationManager())
    }
}
