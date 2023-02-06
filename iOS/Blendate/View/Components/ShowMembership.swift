////
////  ShowMembership.swift
////  Blendate
////
////  Created by Michael on 11/30/22.
////
//
//import SwiftUI
//
//struct ShowMembership: ViewModifier {
//    @Binding var show: Bool
//    
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//            if show {
//                MembershipView(show: $show)
//            }
//        }
//    }
//}
//
//extension View {
//    func membershipOverlay(_ show: Binding<Bool>) -> some View {
//        modifier(ShowMembership(show: show))
//    }
//}
