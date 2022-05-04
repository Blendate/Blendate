//
//  BirthdayView.swift
//  Blendate
//
//  Created by Michael on 1/4/22.
//

import SwiftUI

struct BirthdayView: View {
//    static var detail: Detail = .birthday
    
    @Binding var birthday: Date
    @State var showPicker = false
    @State var pickerSize: CGSize = .zero
    
    let date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    
    var body: some View {
        VStack {
            SignupTitle(.birthday)
            DatePicker(selection: $birthday, in: ...date, displayedComponents: [.date]) {}
            .datePickerStyle(.graphical)
                .tint(.Blue)
            Spacer()
        }
    }
}


struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.birthday)
    }
}

//
//struct BirthdayRect: View {
//    @Binding var birthday: Date
//    let day: String
//    let month: String
//    let year: String
//    
//    init(_ birthday: Binding<Date>){
//        self._birthday = birthday
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy"
//        year = formatter.string(from: birthday.wrappedValue)
//        formatter.dateFormat = "MMMM"
//        month = formatter.string(from: birthday.wrappedValue)
//        formatter.dateFormat = "dd"
//        day = formatter.string(from: birthday.wrappedValue)
//        
//    }
//    
//    var body: some View {
//        HStack {
//            Spacer()
//            Text(month)
//                .fontType(.semibold, 16)
//                .padding(.vertical, 28)
//                .padding(.horizontal, 10)
//                .shadow(radius: 1)
//                .background(.white.opacity(0.8))
//                .cornerRadius(10)
//                .frame(maxWidth: .infinity)
//                .overlay(
//                    Text(month)
//                    .fontType(.semibold, 16)
//                    .foregroundColor(.DarkBlue)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    .frame(maxWidth: .infinity)
//                )
//            Text(day)
//                .fontType(.semibold, 16)
//                .padding(.vertical, 28)
//                .padding(.horizontal, 6)
//                .shadow(radius: 1)
//                .background(.white.opacity(0.8))
//                .cornerRadius(10)
//                .frame(maxWidth: .infinity)
//                .overlay(
//                    Text(day)
//                    .fontType(.semibold, 16)
//                    .foregroundColor(.DarkBlue)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    .frame(maxWidth: .infinity)
//                )
//            Text(year)
//                .fontType(.semibold, 16)
//                .padding(.vertical, 28)
//                .padding(.horizontal, 10)
//                .shadow(radius: 1)
//                .background(.white.opacity(0.8))
//                .cornerRadius(10)
//                .frame(maxWidth: .infinity)
//                .overlay(
//                    Text(year)
//                    .fontType(.semibold, 16)
//                    .foregroundColor(.DarkBlue)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//                    .frame(maxWidth: .infinity)
//                )
//            Spacer()
//        }.padding(.horizontal)
//    }
//}
//
//
//struct ContentView: View {
//    @State var date = Date()
//    
//    var body: some View {
//        ZStack {
//            DatePicker("label", selection: $date, displayedComponents: [.date])
//                .datePickerStyle(CompactDatePickerStyle())
//                .labelsHidden()
//            Image(systemName: "calendar")
//                .resizable()
//                .frame(width: 32, height: 32, alignment: .center)
//                .userInteractionDisabled()
//        }
//    }
//}
//
//struct NoHitTesting: ViewModifier {
//    func body(content: Content) -> some View {
//        SwiftUIWrapper { content }.allowsHitTesting(false)
//    }
//}
//
//extension View {
//    func userInteractionDisabled() -> some View {
//        self.modifier(NoHitTesting())
//    }
//}
//
//struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
//    let content: () -> T
//    func makeUIViewController(context: Context) -> UIHostingController<T> {
//        UIHostingController(rootView: content())
//    }
//    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
//}
