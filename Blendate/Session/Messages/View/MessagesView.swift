//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import MapKit

struct MessagesView: View {
    @StateObject var vm: MessagesViewModel

    init(){
        ColorNavbar()
        self._vm = StateObject(wrappedValue: MessagesViewModel())

    }

    var body: some View {
        NavigationView {
            VStack{
                MatchesView(vm.matches)
                ConversationsView(vm.conversations)
                Spacer()
            }
            .navigationTitle("Blends")
        }
    }
}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
