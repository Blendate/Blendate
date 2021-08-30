//
//  BirthdayView2.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI
import RealmSwift

struct BirthdayView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let isTop = true
    let signup: Bool
    
    @State var monthValue = "December"
    @State var dateValue = "21"
    @State var yearValue = "2021"
    
    @State var birthday = Date()

    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("What is your Birthday?")
                .montserrat(.semibold, 32)
                .foregroundColor(.DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: .center)
                .padding(.bottom, 60)
            VStack {
                DatePicker("label", selection: $birthday, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                birthdayRect
            }//.background(Color.yellow)
            NavigationLink(
                destination: GenderView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
        }.padding(.bottom, 130)
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: isTop) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: "Birthday", isTop: isTop)
        .onChange(of: birthday, perform: { value in
            setDate(value)
        })
        .onAppear {
            setDate(state.user?.userPreferences?.birthday ?? Date())
        }
    }
    
    var birthdayRect: some View {
//        Button(action: {}, label: {
            HStack{
                Spacer()
                BirthdayRect($monthValue, .month)
                Spacer()
                BirthdayRect($dateValue, .day)
                Spacer()
                BirthdayRect($yearValue, .year)
                Spacer()
            }
//            .padding(.horizontal)
//        })
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.birthday = birthday
            }
        } catch {
            print("Unable to open Realm write transaction")
            state.error = "Unable to open Realm write transaction"
        }
        print("wrote: \(String(describing: state.user?._id))")
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
    
    private func setDate(_ date: Date = Date()){
        birthday = date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        
        formatter.dateFormat = "yyyy"
        yearValue = formatter.string(from: date)
        formatter.dateFormat = "MMMM"
        monthValue = formatter.string(from: date)
        formatter.dateFormat = "dd"
        dateValue = formatter.string(from: date)
    }
}

struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayView()
            .environmentObject(AppState())
    }
}


extension View {
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }.allowsHitTesting(false)
    }
}


struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}

enum BirthdayValue {
    case month
    case day
    case year
}

struct BirthdayRect: View {
    
    @Binding var text: String
    let value: BirthdayValue
    let width: (CGFloat,CGFloat)
    
    init(_ text: Binding<String>, _ value: BirthdayValue){
        self._text = text
        self.value = value
        
        switch value {
        case .month:
            width = (85, 100)
        case .day:
            width = (45, 60)
        case .year:
            width = (65, 80)
        }

    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white.opacity(0.8))
                .frame(width: width.0, height: 50, alignment: .center)
                .shadow(radius: 1)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: width.1, height: 40, alignment: .center)
                .shadow(radius: 2)
            
            Text(text)
                .montserrat(.semibold, 16)
                .foregroundColor(.DarkBlue)
        }
    }
}
