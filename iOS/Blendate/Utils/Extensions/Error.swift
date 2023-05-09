//
//  LocalError.swift
//  Blendate
//
//  Created by Michael on 4/30/22.
//

import SwiftUI

protocol ErrorAlert: LocalizedError {
    var title: String {get set}
    var message: String {get set}
    init(title: String, message: String)
}

protocol AlertView: View {
    associatedtype E:ErrorAlert
    var error: State<E?> {get set}
}


extension ErrorAlert {
    ///  alert title
    var errorDescription: String? { title }
    var localizedDescription: String { message }
    ///  alert message
    var failureReason: String? { message }
    /// try again button title
}


extension View {
    func errorAlert<Buttons:View>(
        error passedError: Binding<(any ErrorAlert)?>,
        @ViewBuilder buttons: @escaping (any ErrorAlert) -> Buttons
    ) -> some View {
        modifier( ErrorAlertView(alert: passedError, buttons: buttons) )
//        modifier(ErrorAlertView(alert: passedError, buttons: buttons))
    }
}

struct ErrorAlertView<Buttons: View>: ViewModifier {
    @Binding var alert: (any ErrorAlert)?
    var buttons: (any ErrorAlert) -> Buttons

    var show: Binding<(Bool, any ErrorAlert)> {
        .init {
            if let alert = self.alert {
                return (true, alert)
            } else {
                return (false, Self.Error())
            }
        } set: { newValue in
            if !newValue.0 {
                alert = nil
            }
//            else {
//                alert = newValue.1
//            }
        }
    }
    

    
    var title: String { alert?.title ?? "Error"}
    
    var message: some View {
        Text(alert?.message ?? "An Error has occured")
    }
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: show.0) {
                buttons(show.1.wrappedValue)
            } message: {
                message
            }

//            .alert(title, isPresented: show) { buttons } message: { message }

//            .alert(alert?.title ?? "Error", isPresented: show, actions: buttons, message: message)
    }
    
    struct Error: ErrorAlert {
        var title = "Error"
        var message = "An Error has occured"
    }
}


//extension View {
//    func errorAlert(error passedError: Binding<AlertError?>, retry: (() ->Void)? = nil) -> some View {
//        let alertError = passedError.wrappedValue
//
//        return alert(
//            isPresented: .constant(alertError != nil),
//            error: alertError,
//            actions: { error in
//                Button("Cancel", role: .cancel, action: {passedError.wrappedValue = nil})
//                if let suggestion = error.recoverySuggestion, let retry = retry{
//                    if alertError?.destructive ?? false {
//                        Button(suggestion, role: .destructive, action: retry).foregroundColor(Color.red)
//                    } else {
//                        Button(suggestion, action: retry)
//                    }
//                }
//            },
//            message: { error in
//            if let failureReason = error.failureReason {
//                Text(failureReason)
//            } else {
//                Text("Something went wrong")
//            }
//        })
//    }
//}
