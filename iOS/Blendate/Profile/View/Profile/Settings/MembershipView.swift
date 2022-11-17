//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct MembershipView: View {
    @Binding var membership: Bool
    
    var body: some View {
        VStack {
            Text(membership ? "Subscribed":"Subscribe Now")
            Button(membership ? "Unsubscribe":"Subscribe"){
                membership.toggle()
            }
        }
        
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView(membership: .constant(false))
    }
}
