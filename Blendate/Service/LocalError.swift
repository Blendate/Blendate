//
//  LocalError.swift
//  Blendate
//
//  Created by Michael on 4/30/22.
//

import SwiftUI


//struct AlertError: LocalizedError {
//    case titleEmpty
//
//    var errorDescription: String? {
//        switch self {
//        case .titleEmpty:
//            return "Missing title"
//        }
//    }
//    
//
//    var recoverySuggestion: String? {
//        switch self {
//        case .titleEmpty:
//            return "Article publishing failed due to missing title"
//        }
//    }
//    
//    static func handle(_ error: Error)->AlertError?{
//        if let error = error as? AlertError {
//            return error
//        } else {
//            printD(error.localizedDescription)
//            return nil
//        }
//    }
//
//}

struct AlertError: LocalizedError {
    var errorDescription: String?
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}


struct LocalizedAlertError: LocalizedError {
    var errorDescription: String?
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}






extension View {
//    func errorAlert(error: Binding<LocalizedAlertError?>, buttonTitle: String = "OK") -> some View {
//        let localizedAlertError = error.wrappedValue
//        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
//            Button(buttonTitle) {
//                error.wrappedValue = nil
//            }
//        } message: { error in
//            Text(error.recoverySuggestion ?? "")
//        }
//    }
//
    
    func errorAlert(error: Binding<AlertError?>) -> some View {
        let localizedAlertError = error.wrappedValue
        return alert(
            isPresented: .constant(localizedAlertError != nil),
            error: localizedAlertError,
            actions: { error in
                if let suggestion = error.recoverySuggestion {
                    Button(suggestion, action: {
                        // Recover from an error
                    })
                }
            }, message: { error in
            if let failureReason = error.failureReason {
                Text(failureReason)
            } else {
                Text("Something went wrong")
            }
        })
    }
}

