////
////  SheetState.swift
////  Blendate
////
////  Created by Michael on 4/7/22.
////
//
//import Foundation
//
//class SheetState<State>: ObservableObject {
//    @Published var isShowing = false
//    @Published var state: State? {
//        didSet { isShowing = state != nil }
//    }
//}
//
//
//class ProfileSheet: SheetState<ProfileSheet.State> {
//    enum State: String, CaseIterable {
//        case edit = "Edit"
//        case filter = "Filters"
//        case settings = "Settings"
//        
//        var image: String {
//            switch self {
//            case .edit:
//                return "pencil"
//            case .filter:
//                return "Filter"
//            case .settings:
//                return "settings"
//            }
//            
//        }
//    }
//}
