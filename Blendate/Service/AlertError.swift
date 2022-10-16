//
//  LocalError.swift
//  Blendate
//
//  Created by Michael on 4/30/22.
//

import SwiftUI

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
    func errorAlert(error: Binding<AlertError?>, retry: (() ->Void)? = nil) -> some View {
        let localizedAlertError = error.wrappedValue
        return alert(
            isPresented: .constant(localizedAlertError != nil),
            error: localizedAlertError,
            actions: { error in
                Button("Cancel", role: .cancel, action: {})
                if let suggestion = error.recoverySuggestion, let retry = retry {
                    if let errorDesc = localizedAlertError?.errorDescription, errorDesc == "Delete Acount"{
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
    
    func asyncErroAlert(error: Binding<AlertError?>, retry: (() async ->Void)? = nil) -> some View {
        let localizedAlertError = error.wrappedValue
        return alert(
            isPresented: .constant(localizedAlertError != nil),
            error: localizedAlertError,
            actions: { error in
                if let suggestion = error.recoverySuggestion, let retry = retry {
                    AsyncButton(suggestion, action: retry)
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

