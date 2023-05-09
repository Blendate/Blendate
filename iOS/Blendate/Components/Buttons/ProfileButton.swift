//
//  ProfileButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/17/23.
//

import SwiftUI

struct ProfileButton: View {
    let type: ButtonType
    
    var color: Color = .white
    var foreground: Color { color == .white ? .Blue : .white }
    var size: CGFloat = 35
    var padding: CGFloat = 15
    
    var tapped: (_ type: ButtonType)->Void

    var body: some View {
        Button(action: tap) {
            VStack {
                Image(systemName: type.systemName)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(foreground)
                    .frame(width: size, height: size)
                    .padding(padding)
                    .background(color)
                    .clipShape(Circle())
                Text(type.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func tap(){ tapped(type) }

    
}
enum ButtonType: String, Identifiable {
    case edit, filters, settings
    
    var id: String { title }
    
    var title: String {
        self.rawValue.uppercased()
    }
    
    var systemName: String {
        switch self {
        case .edit:
            return "pencil"
        case .filters:
            return "slider.horizontal.3"
        case .settings:
            return "gear"
        }
    }
    
}


struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton(type: .edit) { tap in }
    }
}
