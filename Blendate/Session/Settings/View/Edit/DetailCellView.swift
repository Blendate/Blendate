//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

//typealias Value<V> = Group<V> where V:View
//typealias Destination<V> = Group<V> where V:View
//struct DetailCellView<V1, V2>: View where V1: View, V2: View {
struct DetailCellView:View {

    let detail: Detail
    @Binding var details: UserDetails
    @State var show: Bool = false
    let unchageable: [Detail] = [.name, .birthday]

    init(_ detail: Detail, _ details: Binding<UserDetails>) {
        self.detail = detail
        self._details = details
    }

    var body: some View {
        Button(action: {
            if !unchageable.contains(detail) || detail == .parent {
                show = true
            }
        }) {
            HStack {
                Text(detail.rawValue)
                    .foregroundColor(.DarkBlue)
                Spacer()
                switch detail {
                case .name, .birthday, .parent:
                   value()
                default:
                    Group {
                        if detail.valueValid(details) && detail != .photos {
                            value()
                                .foregroundColor(.Blue)
                        } else {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.Blue)
                        }
                    }
                }
            }
            .padding(.vertical, 5)
        }
        .disabled(unchageable.contains(detail) )
        .sheet(isPresented: $show, onDismiss: {}) {
            SignupViewMod($details, detail)
        }
    }
    
    @ViewBuilder func value()->some View {
        switch detail {
        case .name:
            Text(details.firstname + " " + details.lastname).foregroundColor(.gray)
        case .birthday:
            Text("\(details.age())")
                .foregroundColor(.gray)
        case .gender:
            Text(details.gender)
                .foregroundColor(.gray)
        case .parent:
            Toggle("", isOn: $details.isParent)
                    .tint(.Blue)
                    .padding(.trailing, 1)
        case .numberKids:
            Text(details.kidsString() ?? "")
        case .kidsRange:
            Text(details.rangeString())
        case .location:
            Text(details.location.name)
        case .bio:
            Text(details.bio.prefix(20) + "...")
        case .photos:
            Text("")
        case .height:
            Text(details.heightString() ?? "")
        case .relationship:
            Text(details.relationship)
        case .wantKids:
            Text(details.familyPlans)
        case .work:
            Text(details.workTitle)
        case .education:
            Text(details.schoolTitle)
        case .mobility:
            Text(details.mobility)
        case .religion:
            Text(details.religion)
        case .politics:
            Text(details.politics)
        case .ethnicity:
            Text(details.ethnicity)
        case .vices:
            Text(viceString() ?? "")
        case .interests:
            Text(viceString() ?? "")
        }
    }
    private func viceString()->String?{
         if !details.vices.isEmpty {
             let first = details.vices.map({$0}).prefix(upTo: 2).joined(separator:", ")
             let moreAmount = details.vices.count - 2
             
             let more = moreAmount < 1 ? "":" +\(moreAmount) more"
             
             return first + more
         } else {
             return nil
         }
     }
}

extension Detail {
    enum Groups: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general = "General"
        case personal = "Personal"
        case children = "Children"
        case background = "Background"
        case other = "Other"
        
        var cells: [Detail] {
            switch self {
            case .general:
                return [.name, .birthday, .photos]
            case .personal:
                return [.bio, .height, .relationship, .work, .education]
            case .children:
                return [.parent, .numberKids, .kidsRange, .wantKids]
            case .background:
                return [.religion, .ethnicity, .politics]
            case .other:
                return [.mobility, .vices]
            }
        }
    }
}

struct DetailCellView_Previews: PreviewProvider {
    @State static var details = dev.michael.details
    static var previews: some View {
        List {
            DetailCellView(.ethnicity, $details)
        }
    }
}

