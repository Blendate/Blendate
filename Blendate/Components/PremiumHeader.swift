//
//  PremiumHeader.swift
//  Blendate
//
//  Created by Michael on 4/28/22.
//

import SwiftUI

struct PremiumHeader: View {
    @State var showMembership = false
    @Binding var user: User
    
    var body: some View {
        let premium = user.settings.premium
        Button(action: {
            showMembership = true
        }) {
            HStack {
                Text("Premium")
                    .foregroundColor(premium ? .DarkBlue:.gray)
                Image(systemName: premium ? "lock.open.fill":"lock.fill")
                    .foregroundColor(premium ? .DarkBlue:.gray)
                Spacer()
                if !premium {
                    Text("Upgrade")
                        .foregroundColor(.Blue)
                }
            }
        }.disabled(premium)
        .sheet(isPresented: $showMembership) {
            do {
                try UserService().updateUser(with: user)
            } catch {
                print("There was a problem saving your settings, please check your connection and try again")
            }
        } content: {
            MembershipView(membership: $user.settings.premium)
        }
    }
}



struct PremiumHeader_Previews: PreviewProvider {
    static var previews: some View {
        PremiumHeader(user: dev.$bindingMichael)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
