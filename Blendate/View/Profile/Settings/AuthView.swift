////
////  AuthView.swift
////  Blendate
////
////  Created by Michael on 7/22/21.
////
//
//import SwiftUI
//import RealmSwift
//
//enum AuthType: String, Codable {
//    case facebook = "Facebook"
//    case apple = "Apple"
//    case google = "Google"
//    case email = "Email"
//    case phone = "Phone"
//}
//
//struct Authentication: Codable {
//    let authType: AuthType
//    let title: String
//    let token: String?
//}
//
//
//struct AuthView: View {
//
//    let authType: AuthType
//    
//    init(_ authType: AuthType){
//        self.authType = authType
//    }
//    
//    var body: some View {
//        VStack {
//            Button(action: {}, label: {
//                Text("Add")
//            })
//        }
//    }
//
//
////
////    var authSwitch: some View {
////        switch self.authType {
////        case .email:
////            VStack{}
////        case .facebook:
////            VStack{}
////        case .apple:
////            VStack{}
////        case .google:
////            VStack{}
////        case .phone:
////            VStack{}
////        }
////    }
//}
//
//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView(.email)
//    }
//}
