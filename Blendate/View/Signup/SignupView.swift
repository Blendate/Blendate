//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct NextButton: View {
    
    var title: String = "Next Step"
    var action: ()->Void

    var body: some View {
        Button(action: action){
            Text(title)
                .padding()
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(Color.Blue)
                .clipShape(Capsule())
        }
    }
}

struct ImagePlaceHolder: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 150, height: 150)
            .foregroundColor(.Blue)
    }
}


enum ViewStyle {
    case none
    case signup
}


struct SignupView: View {
    
    var body: some View {
        NavigationView {
            NameView(true)
        }
    }
}

struct NameView: View {
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                Text("What is your name")
                TextField("Firstname", text: $session.user.firstName)
                TextField("Lastname", text: $session.user.lastName)
                Text("Last names help build authenticity and will only be shared with matches.")
                if signup {
                    NavigationLink(
                        destination: BirthdayView(true),
                        isActive: $next,
                        label: {
                            NextButton(action: {next.toggle()})
                        })
                }

            }
    }
}

struct BirthdayView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                DatePicker("Birthday", selection: $session.user.birthday)
                if signup {
                    NavigationLink(
                        destination: GenderView(true),
                        isActive: $next,
                        label: {
                            NextButton(action: {next.toggle()})
                        })
                }

            }
    }
}

struct GenderView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                HStack {
                    Button("Male", action: {
                        session.user.gender = .male
                        next.toggle()
                    })
                    Button("Female", action: {
                        session.user.gender = .female
                        next.toggle()
                    })
                }
                HStack {
                    Button("Non-binary", action: {
                        session.user.gender = .nonBinary
                        next.toggle()
                    })
                    Button("Prefer not to say", action: {
                        session.user.gender = .other
                        next.toggle()
                    })
                }
                if signup {
                    NavigationLink(
                        destination: ParentView(true),
                        isActive: $next,
                        label: {Text("")})
                }

            }
    }
}

struct ParentView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var kids = false
    @State private var location = false

    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Parent")
            HStack {
                NavigationLink(
                    destination: NumberKidsView(true),
                    isActive: $kids,
                    label: {
                        NextButton(title: "Yes") {
                            session.user.isParent = true
                            kids.toggle()
                        }
                    }
                )
                
                NavigationLink(
                    destination: LocationView(true),
                    isActive: $location,
                    label: {
                        NextButton(title: "No") {
                            session.user.isParent = false
                            location.toggle()
                        }
                    }
                )
                
            }
        }
    }
}

struct NumberKidsView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    var kidsProxy: Binding<Double> {
        Binding<Double>(
            get: { Double(session.user.children) },
            set: { session.user.children = Int($0) }
        )
    }
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Number of Kids")
            Slider(value: kidsProxy, in: 0...12, step: 1)
            if signup {
                NavigationLink(
                    destination: KidsRangeView(true),
                    isActive: $next,
                    label: {Text("Next")}
                )
            }
            
        }
    }
}

struct KidsRangeView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    var minProxy: Binding<Double> {
        Binding<Double>(
            get: { Double(session.user.childrenAge.min) },
            set: { session.user.childrenAge.min = Int($0) }
        )
    }
    
    var maxProxy: Binding<Double> {
        Binding<Double>(
            get: { Double(session.user.childrenAge.max) },
            set: { session.user.childrenAge.max = Int($0) }
        )
    }
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Min")
            Slider(value: minProxy, in: 0...40, step: 1)
            Text("Max")
            Slider(value: maxProxy, in: 0...40, step: 1)

            if signup {
                NavigationLink(
                    destination: LocationView(true),
                    isActive: $next,
                    label: {Text("Next")}
                )
            }
            
        }
    }
}

struct LocationView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                TextField("Location", text: $session.user.location)
                if signup {
                    NavigationLink(
                        destination: AddPhotosView(true),
                        isActive: $next,
                        label: {
                            NextButton(action: {next.toggle()})
                        })
                }

            }
    }
}

struct AddPhotosView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                Text("Images")
                if signup {
                    NavigationLink(
                        destination: AboutView(true),
                        isActive: $next,
                        label: {
                            NextButton(action: {next.toggle()})
                        })
                }

            }
    }
}

struct AboutView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    func completeSignup(){
        API.User.setUserData(uid: session.user.uid, user: session.user) {
            session.completedSignup = true
        } onError: { (errMSG) in
            print(errMSG)
        }

    }
    
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                TextEditor(text: $session.user.bio)
                    .frame(height: 150)
                if signup {
                    NavigationLink(
                        destination: HeightView(true),
                        isActive: $next,
                        label: {
                            NextButton(title: "More", action: {
                                session.user.completeSignup = true
                                next.toggle()
                                
                            })
                        })
                    NextButton(title: "More", action: {
                        session.user.completeSignup = true
                        completeSignup()
                    })
                    
                }

            }
    }
}

struct WantKidsView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            Text("Want kids?")
            HStack {
                NextButton(title: "Yes") {
                    session.user.familyPlans = .wantMore
                    next.toggle()
                }
                NextButton(title: "No") {
                    session.user.familyPlans = .dontWant
                    next.toggle()
                }
            }
            NextButton(title: "No Preference") {
                session.user.familyPlans = .dontCare
                next.toggle()
            }
            if signup {
                NavigationLink(
                    destination: AddPhotosView(true),
                    isActive: $next,
                    label: {Text("")}
                )
            }
            
        }
    }
}



struct InterestedView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                ImagePlaceHolder()
                HStack {
                    Button("Friendship", action: {
                        session.user.gender = .male
                        next.toggle()
                    })
                    Button("Relationship", action: {
                        session.user.gender = .female
                        next.toggle()
                    })
                }
                Button("Both", action: {
                    session.user.gender = .nonBinary
                    next.toggle()
                })
                if signup {
                    NavigationLink(
                        destination: LocationView(true),
                        isActive: $next,
                        label: {
                            Text("")
                        })
                }

            }
    }
}



struct HeightSlider: View {
    @Binding var height: Double
    var sliderHeight:CGFloat

    var body: some View {
        Slider(value: $height, in: 120...250, step: 1)
        .rotationEffect(.degrees(-90.0), anchor: .topLeading)
        .frame(width: sliderHeight)
        .offset(y: sliderHeight)
    }
}

struct HeightView: View {
    
    @EnvironmentObject var session: Session
    
    let signup: Bool
    @State private var next = false
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            ImagePlaceHolder()
            GeometryReader { geo in
                HeightSlider(
                    height: $session.user.height,
                    sliderHeight: geo.size.height
                )
            }
            Text(String(session.user.height))
            if signup {
                NavigationLink(
                    destination: ParentView(true),
                    isActive: $next,
                    label: {
                        NextButton(action: {next.toggle()})
                    })
            }
            
        }
    }
}

