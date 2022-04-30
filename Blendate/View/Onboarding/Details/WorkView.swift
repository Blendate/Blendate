//
//  WorkVew.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct WorkView: View {
    @Binding var workTitle: String

    
    var body: some View {
        VStack {
            Text("What is your job title?")
                .fontType(.regular, 16)
                .foregroundColor(.DarkBlue)
                .padding(.top,5)
                .multilineTextAlignment(.center)
            TextField("", text: $workTitle)
                    .fontType(.semibold, 22)
                    .padding(.horizontal, 40)
                    .foregroundColor(.DarkBlue)
                    .textFieldStyle(.roundedBorder)
        }
    }

}
#if DEBUG
struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.work)
    }
}
#endif

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
