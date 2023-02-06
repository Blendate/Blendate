//
//  DetailBackground.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI

extension View {
    func background(detail: Detail? = nil, bottom: Bool = true)->some View{
        modifier(DetailBackground(detail: detail, bottom: bottom))
    }
}
struct DetailBackground: ViewModifier {
    let detail: Detail?
    let bottom: Bool
    
    var ellipse: String { bottom ? "Ellipse_Bottom" : "Ellipse_Top" }
    
    func body(content: Content) -> some View {
        ZStack {
            VStack(spacing: 0) {
                if bottom {
                    Spacer()
                }
                ZStack(alignment: .center) {
                    Image(ellipse)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                        .edgesIgnoringSafeArea(.vertical)
                    if let imageString = svgName {
                        Image(imageString)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 270, height: 226 , alignment: .center)
                    }
                }
                if !bottom {
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            content
        }
    }
    
    #warning("Switch to SVGs")
    var svgName: String? {
        switch detail {
        case .name: return "Family"
        case .birthday: return "Birthday"
        case .gender: return "Gender"
        case .isParent, .children, .childrenRange, .familyPlans: return "Family"
        case .relationship: return "Relationship"
        case .work: return "Work"
        case .education: return "Education"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        case .seeking: return "Interested"
        default:
            return nil
        }
    }
}

struct DetailBackground_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                Text("Test")
            }
                .background(detail: .gender)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Next"){}
                    }
                }
        }
    }
}
