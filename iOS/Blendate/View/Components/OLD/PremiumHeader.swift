////
////  PremiumHeader.swift
////  Blendate
////
////  Created by Michael on 4/28/22.
////
//
//import SwiftUI
//
//struct PremiumHeader: View {
//    @State var showMembership = false
//    @Binding var settings: Settings
//    @Binding var user: User
//    var body: some View {
//        let premium = user.premium.active
//        Button(action: {
//            showMembership = true
//        }) {
//            HStack {
//                Text("Premium")
//                    .foregroundColor(premium ? .DarkBlue:.gray)
//                Image(systemName: premium ? "lock.open.fill":"lock.fill")
//                    .foregroundColor(premium ? .DarkBlue:.gray)
//                Spacer()
//                if !premium {
//                    Text("Upgrade")
//                        .foregroundColor(.Blue)
//                }
//            }
//        }.disabled(premium)
//        .sheet(isPresented: $showMembership) {
//            do {
//                try UserService().update(user)
//            } catch {
//                print("There was a problem saving your settings, please check your connection and try again")
//            }
//        } content: {
//            MembershipView()
//        }
//    }
//}
//
//
//
//struct PremiumHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        PremiumHeader(settings: .constant(Settings()), user: .constant(dev.michael) )
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
