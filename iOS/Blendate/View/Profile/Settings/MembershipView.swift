//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct MembershipView: View {
    @Binding var premium: Premium
    
    var body: some View {
        VStack {
            Text(premium.active ? "Subscribed":"Subscribe Now")
            Button(premium.active ? "Unsubscribe":"Subscribe"){
                premium.active.toggle()
            }
        }
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView(premium: .constant(Premium()))
    }
}
