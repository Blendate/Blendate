//
//  SignupViewMod.swift
//  Blendate
//
//  Created by Michael on 4/8/22.
//

import SwiftUI

enum Position {
    case top
    case bottom
    case center
}


struct SignupViewMod: View {
    @Binding var details: UserDetails

    let imagePosition: Position
    let type: Detail
    
    init(_ details: Binding<UserDetails>, _ type: Detail){
        self._details = details
        self.type = type
        self.imagePosition = type.imagePosition
    }
    
    var body: some View {
        mainView
        .ignoresSafeArea(.keyboard)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SignupViewMod($details, type.next(details.isParent))
                } label: {
                    Text(type.trailingString(details))
                        .fontWeight(.bold)
                        .tint(imagePosition == .top ? .white:.Blue)
                }.disabled(!type.valueValid(details) && type.trailingString(details) == "Next")
            }
        }
    }
    
    var mainView: some View {
        Group {
            if type.position == .center {
                center
            } else {
                positioning
            }
        }
//        ZStack {
//            VStack(spacing: 0) {
//                if imagePosition == .bottom {
//                    Spacer()
//                }
//                imageBubble
//                if imagePosition == .top {
//                    Spacer()
//                }
//            }
//            VStack(spacing: 0) {
//                if type.position == .bottom {
//                    Spacer()
//                }
//                SignupTitle(type, imagePosition)
//                type.getDestination($details)
//                if type.position == .top {
//                    Spacer()
//                }
//            }
//        }
    }
    
    var center: some View {
        VStack(spacing: 0) {
            if imagePosition == .bottom {
                VStack(spacing: 0) {
                    Spacer()
                    SignupTitle(type, imagePosition)
                    type.getDestination($details)
                }
            }
            imageBubble
            if imagePosition == .top {
                VStack(spacing: 0) {
                    SignupTitle(type, imagePosition)
                    type.getDestination($details)
                    Spacer()
                }
//                Spacer()

            }
        }
        .edgesIgnoringSafeArea(imagePosition == .top ? .top:.bottom)

    }
    
    var positioning: some View {
        ZStack {
            VStack(spacing: 0) {
                if imagePosition == .bottom {
                    Spacer()
                }
                imageBubble
                if imagePosition == .top {
                    Spacer()
                }
            }.edgesIgnoringSafeArea(imagePosition == .top ? .top:.bottom)

            VStack(spacing: 0) {
                if type.position == .bottom {
                    Spacer()
                }
                SignupTitle(type, imagePosition)
                type.getDestination($details)
                if type.position == .top {
                    Spacer()
                }
            }
        }
    }
    
    var centerView: some View {
        Group {
            VStack(spacing: 0){
                Spacer()
                imageBubble
            }
            VStack(spacing: 0){
                SignupTitle(type, imagePosition)
                type.getDestination($details)
                    .padding(.bottom)
            }

        }
    }
    
    var positionView: some View {
        VStack(spacing: 0) {
            if imagePosition == .bottom {
                Spacer()
                 SignupTitle(type, imagePosition)
                type.getDestination($details)
                 Spacer()
            }
            imageBubble
            if imagePosition == .top{
                Spacer()
                 SignupTitle(type, imagePosition)
                type.getDestination($details)
                 Spacer()
            }
        }
    }


    
    var imageBubble: some View {
        ZStack(alignment: .center) {
            Image(imagePosition == .top ? "Ellipse_Top":"Ellipse_Bottom")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                .edgesIgnoringSafeArea(.vertical)
            if let imageString = type.svgName {
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




struct SignupViewMod_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.name)
        PreviewSignup(.birthday)
        PreviewSignup(.gender)

    }
}



extension Detail{
    func valueValid(_ details: UserDetails) -> Bool {
        switch self {
        case .name:
            return (details.firstname.count > 2) && !details.firstname.isBlank
        case .birthday:
            return details.age() >= 18
        case .gender:
            return !details.gender.isEmpty
        case .parent:
            return true
        case .numberKids:
            return details.children > 0
        case .kidsRange:
            return details.childrenRange.max != 0
        case .location:
            return !details.location.name.isBlank
        case .bio:
            return !details.bio.isBlank
        case .photos:
            return !details.photos.isEmpty
        case .interests:
            return false
        case .height:
            return details.height != nil
        case .relationship:
            return !details.relationship.isEmpty
        case .wantKids:
            return !details.familyPlans.isEmpty
        case .work:
            return !details.workTitle.isBlank
        case .education:
            return !details.schoolTitle.isBlank
        case .mobility:
            return !details.mobility.isEmpty
        case .religion:
            return !details.religion.isEmpty
        case .politics:
            return !details.politics.isEmpty
        case .ethnicity:
            return !details.ethnicity.isEmpty
        case .vices:
            return !details.vices.isEmpty
        }
    }
    
    func trailingString(_ details: UserDetails)->String {
        switch self {
        case .height:
            return details.height == nil ? "Skip":"Next"
        case .relationship:
            return details.relationship.isEmpty ? "Skip":"Next"
        case .wantKids:
            return details.familyPlans.isEmpty ? "Skip":"Next"
        case .work:
            return details.workTitle.isBlank ? "Skip":"Next"
        case .education:
            return details.schoolTitle.isBlank ? "Skip":"Next"
        case .mobility:
            return details.mobility.isEmpty ? "Skip":"Next"
        case .religion:
            return details.religion.isEmpty ? "Skip":"Next"
        case .politics:
            return details.politics.isEmpty ? "Skip":"Next"
        case .ethnicity:
            return details.ethnicity.isEmpty ? "Skip":"Next"
        case .vices:
            return details.vices.isEmpty ? "Skip":"Next"
        case .interests:
            return details.interests.isEmpty ? "":""
        default:
            return "Next"

        }
    }
}
