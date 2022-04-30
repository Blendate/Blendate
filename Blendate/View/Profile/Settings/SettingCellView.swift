//
//  SettingCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct SettingCellView: View {
    
    let cell: SettingCell
    @Binding var settings: UserSettings
    @State var showPremium = false
    
    init(_ cell: SettingCell, _ settings: Binding<UserSettings>){
        self._settings = settings
        self.cell = cell
    }
    
    var body: some View {
        let title = cell.id
        let subtitle = cell.subtitile
        HStack {
            VStack(alignment: .leading){
                Text(title)
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            content()
        }.padding(.vertical, 5)
    }
    
    @ViewBuilder func content() -> some View {
        switch cell {
        case .membership:
            NavigationLink(destination: MembershipView(membership: $settings.premium),
                           isActive: $showPremium) {
//                Text(settings.premium ? "Manage":"Subscribe")
            }
        case .invisble:
            Toggle(isOn: $settings.invisbleBlending) {}
                .fixedSize().tint(.Blue)
                .padding(.trailing, 5)
        case .notifications:
            Toggle(isOn: $settings.notifications.isOn) {}.fixedSize().tint(.Blue)
                .padding(.trailing, 5)
        case .community:
            NavigationLink("", destination:
                Text("Learn more info about upcoming community."))
        case .auth:
            Text(settings.providers.first?.id ?? "")
        case .help:
            NavigationLink(destination: HelpCenterView()) {}
        case .privacy:
            NavigationLink("", destination:
                Text("Privacy Policy") )
        case .about:
            NavigationLink("", destination:
                Text("Blendate Mission") )
        }
    }
}

enum SettingCell: String, Identifiable, Equatable, CaseIterable {

    var id: String {self.rawValue}
    case membership = "Membership"
    case invisble = "Invisible Blending"
    case notifications = "Notifications"
    case community = "Community"
    case auth = "Signin"
    case help = "Help Center"
    case privacy = "Privacy Policy"
    case about = "About Us"
    
    var subtitile: String {
        switch self {
//        case .membership
//            return "Premium"
        case .invisble:
            return "Hide your profile on other's lineup"
        case .notifications:
            return "New messages and new blends"
        case .community:
            return "Coming Soon"
        default:
            return ""
        }
    }

    
    enum Groups: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case account = "Account"
        case auth = "Authenticated"
        case legal = "About Blendate"
        
        var cells: [SettingCell] {
            switch self {
            case .account:
                return [.membership, .invisble, .notifications, .community]
            case .auth:
                return [.auth]
            case .legal:
                return [.help, .privacy, .about]
            }
        }
    }
}


struct SettingCellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellView(.membership, .constant(dev.michael.settings))
    }
}
