//
//  LocalError.swift
//  Blendate
//
//  Created by Michael on 4/30/22.
//

import SwiftUI

struct AlertError: LocalizedError {
    
    init(title: String, message: String, recovery: String? = nil, help: String? = nil, destructive: Bool = false) {
        self.errorDescription = title
        self.failureReason = message
        self.recoverySuggestion = recovery
        self.helpAnchor = help
        self.destructive = destructive
    }

    var errorDescription: String? // Title
    var failureReason: String? //
    var recoverySuggestion: String?
    var helpAnchor: String?
    var destructive: Bool
}


//

extension View {
    func errorAlert(error: Binding<AlertError?>, retry: (() ->Void)? = nil) -> some View {
        let alertError = error.wrappedValue
        
        return alert(
            isPresented: .constant(alertError != nil),
            error: alertError,
            actions: { error in
                Button("Cancel", role: .cancel, action: {})
                if let suggestion = error.recoverySuggestion, let retry = retry{
                    if alertError?.destructive ?? false {
                        Button(suggestion, role: .destructive, action: retry).foregroundColor(Color.red)
                    } else {
                        Button(suggestion, action: retry)
                    }
                }
            },
            message: { error in
            if let failureReason = error.failureReason {
                Text(failureReason)
            } else {
                Text("Something went wrong")
            }
        })
    }
    
//    func asyncErroAlert(error: Binding<AlertError?>, retry: (() async ->Void)? = nil) -> some View {
//        let localizedAlertError = error.wrappedValue
//        return alert(
//            isPresented: .constant(localizedAlertError != nil),
//            error: localizedAlertError,
//            actions: { error in
//                if let suggestion = error.recoverySuggestion, let retry = retry {
//                    AsyncButton(suggestion, action: retry)
//                }
//            }, message: { error in
//            if let failureReason = error.failureReason {
//                Text(failureReason)
//            } else {
//                Text("Something went wrong")
//            }
//        })
//    }
}



//enum FirebaseError: LocalizedError {
//    case decode
//    case server
//    case generic(String)
//
//
//    var errorDescription: String? {
//        switch self {
//        case .decode:
//            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
//        case .server:
//            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
//        case .generic(let string):
//            return NSLocalizedString(string, comment: "Firebase Error")
//        }
//    }
//
//    var recoverySuggestion: String? {
//        switch self {
//        case .decode:
//            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
//        case .server:
//            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
//        case .generic(let string):
//            return NSLocalizedString(string, comment: "Firebase Error")
//        }
//    }
//}
