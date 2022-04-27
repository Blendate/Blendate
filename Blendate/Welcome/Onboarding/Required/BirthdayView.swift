//
//  BirthdayView.swift
//  Blendate
//
//  Created by Michael on 1/4/22.
//

import SwiftUI

struct BirthdayView: View {
    static var detail: Detail = .birthday
    
    @Binding var birthday: Date
    @State var showPicker = false
    @State var pickerSize: CGSize = .zero
    var body: some View {
        
//        ZStack {
//            DatePicker("label", selection: $birthday, displayedComponents: [.date])
//                .datePickerStyle(CompactDatePickerStyle())
//                .labelsHidden()
//                .frame(width: UIScreen.main.bounds.width, height: 100)
//            BirthdayRect($birthday)
////            Image(systemName: "calendar")
////                .resizable()
////                .frame(width: 32, height: 32, alignment: .center)
////                .userInteractionDisabled()
//        }.background(Color.clear)
        
        VStack {
            Button(action: {showPicker = true}) {
                BirthdayRect($birthday)
            }
            if showPicker {
                    DatePicker(selection: $birthday, displayedComponents: [.date]) {}
                    .datePickerStyle(.graphical)
                        .labelsHidden()
                        .fontType(.regular, 32)
                    .onChange(of: birthday, perform: { value in
                        birthday = value
                    })
            } else {
                Rectangle().fill(Color.clear)
                    .frame(height: 250)
                
            }
        }
        
//        DatePicker(selection: $birthday, displayedComponents: [.date]) {}
//            .datePickerStyle(.wheel)
//            .labelsHidden()
//            .fontType(.regular, 32)
//            .padding(.vertical)
//        .onChange(of: birthday, perform: { value in
//            birthday = value
//        })

//        VStack {
//            ZStack {
//                BirthdayRect($birthday)
//                DatePicker(selection: $birthday, displayedComponents: [.date]) {}
//                    .frame(width: getRect().width - 30, height: 60)
//                    .scaleEffect(5)
//                    .datePickerStyle(CompactDatePickerStyle())
//                    .labelsHidden()
//                    .opacity(0.02)
//                    .clipShape(Capsule())
//            }
//        }

    }

}

struct BirthdayRect: View {
    @Binding var birthday: Date
    let day: String
    let month: String
    let year: String
    
    init(_ birthday: Binding<Date>){
        self._birthday = birthday
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        year = formatter.string(from: birthday.wrappedValue)
        formatter.dateFormat = "MMMM"
        month = formatter.string(from: birthday.wrappedValue)
        formatter.dateFormat = "dd"
        day = formatter.string(from: birthday.wrappedValue)
        
    }
    

    var body: some View {
        HStack {
            Spacer()
            Text(month)
                .fontType(.semibold, 16)
                .padding(.vertical, 28)
                .padding(.horizontal, 10)
                .shadow(radius: 1)
                .background(.white.opacity(0.8))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text(month)
                    .fontType(.semibold, 16)
                    .foregroundColor(.DarkBlue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .frame(maxWidth: .infinity)
                )
            Text(day)
                .fontType(.semibold, 16)
                .padding(.vertical, 28)
                .padding(.horizontal, 6)
                .shadow(radius: 1)
                .background(.white.opacity(0.8))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text(day)
                    .fontType(.semibold, 16)
                    .foregroundColor(.DarkBlue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .frame(maxWidth: .infinity)
                )
            Text(year)
                .fontType(.semibold, 16)
                .padding(.vertical, 28)
                .padding(.horizontal, 10)
                .shadow(radius: 1)
                .background(.white.opacity(0.8))
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text(year)
                    .fontType(.semibold, 16)
                    .foregroundColor(.DarkBlue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .frame(maxWidth: .infinity)
                )
            Spacer()
        }.padding(.horizontal)
    }
}

struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.birthday)
    }
}


struct ContentView: View {
    @State var date = Date()
    
    var body: some View {
        ZStack {
            DatePicker("label", selection: $date, displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .labelsHidden()
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
                .userInteractionDisabled()
        }
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }.allowsHitTesting(false)
    }
}

extension View {
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}
