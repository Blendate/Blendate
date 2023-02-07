//
//  SettingCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

extension SettingsView {
    struct ToggleView: View {
        let title: String
        @Binding var value: Bool
        
        init(_ title: String, value: Binding<Bool>) {
            self.title = title
            self._value = value
        }
        
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Toggle(isOn: $value) {}
                    .fixedSize()
                    .tint(.Blue)
                    .padding(.trailing, 5)
            }
        }
    }
    
    struct ProviderCell: View {
        let provider: Provider
        @Binding var userProviders: [Provider]
        var body: some View {
            HStack {
                VStack(alignment: .leading){
                    Text(provider.id)
                }
                Spacer()
                if let prov = checkPovider(with: provider){
                    Text(prov.rawValue)
                } else {
                    HStack{
                        Text("Link")
                        Image(systemName: "chevron.right")
                    }
                }
            }.padding(.vertical, 5)
                .listRowBackground(Color.white)
        }
        
        func checkPovider(with provider: Provider)->Provider?{
            return userProviders.first(where: {$0 == provider})
        }
    }

}
enum Provider: String, Codable, Identifiable, Hashable, CaseIterable {
    var id: String {self.rawValue}
    case apple = "Apple"
    case facebook = "Facebook"
    case phone = "Phone"
}
