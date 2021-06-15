//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct EditProfile: View {

    @Binding var user: User
    
    init(_ user: Binding<User>){
        self._user = user
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                general
                personal
                children
                background
                other
            }
        }.padding()
    }
    
    var general: some View {
        VStack(alignment: .leading) {
            Text("General")
                .fontWeight(.semibold)
                .font(.title)
                .padding(.vertical)
            NavigationLink(
                destination: NameView(false, $user),
                label: {
                    EditCell(title: "Name", value: user.fullName())
                })
            NavigationLink(
                destination: AboutView(false, $user),
                label: {
                    EditCell(title: "About", value: user.bio)
                })
        }
    }
    var personal: some View {
        VStack(alignment: .leading) {
            Text("Personal")
                .fontWeight(.semibold)
                .font(.title)
                .padding(.vertical)
            NavigationLink(
                destination: BirthdayView(false, $user),
                label: {
                    EditCell(title: "Age", value: "user.birthday")
                })
            NavigationLink(
                destination: HeightView(false, $user),
                label: {
                    EditCell(title: "Height", value: "\(user.height)")
                })
            NavigationLink(
                destination: RelationshipView(false, $user),
                label: {
                    EditCell(title: "Relationship Status", value: user.relationship?.rawValue)
                })
            NavigationLink(
                destination: WorkView(false, $user),
                label: {
                    EditCell(title: "Job Title", value: user.workTitle)
                })
            NavigationLink(
                destination: EducationView(false, $user),
                label: {
                    EditCell(title: "Education", value: user.schoolTitle)
                })
        }
    }
    var children: some View {
        VStack(alignment: .leading) {
            Text("Children")
                .fontWeight(.semibold)
                .font(.title)
                .padding(.vertical)
            NavigationLink(
                destination: ParentView(false, $user),
                label: {
                    EditCell(title: "Parental Status", value: user.isParent ? "Yes":"No")

                })

            if user.isParent {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        EditCell(title: "# of Children", value: "\(user.children)")
                    })
                NavigationLink(
                    destination: KidsRangeView(false, $user),
                    label: {
                        EditCell(title: "Children's Age Range", value: "\(user.childrenAge.min)-\(user.childrenAge.min)")
                    })
            }
            NavigationLink(
                destination: WantKidsView(false, $user),
                label: {
                    EditCell(title: "Wants More Children", value: user.familyPlans?.rawValue)
                })
        }
    }
    var background: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .fontWeight(.semibold)
                .font(.title)
                .padding(.vertical)
            NavigationLink(
                destination: ReligionView(false, $user),
                label: {
                    EditCell(title: "Religion", value: user.religion?.rawValue)
                })
            NavigationLink(
                destination: EthnicityView(false, $user),
                label: {
                    EditCell(title: "Ethnicity", value: user.ethnicity?.rawValue)
                })
            NavigationLink(
                destination: PoliticsView(false, $user),
                label: {
                    EditCell(title: "Political Views", value: user.politics?.rawValue)
                })
        }
    }
    var other: some View {
        VStack(alignment: .leading) {
            Text("Other")
                .fontWeight(.semibold)
                .font(.title)
                .padding(.vertical)
            NavigationLink(
                destination: MobilityView(false, $user),
                label: {
                    EditCell(title: "Mobility", value: user.mobility?.rawValue)
                })
            NavigationLink(
                destination: VicesView(false, $user),
                label: {
                    EditCell(title: "Vices", value: user.vices.first?.rawValue)
                })
        }
    }
}

struct EditCell: View {
    let title: String
    let value: String?
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.gray)
                Spacer()
                if let value = value {
                    if value.isEmpty {
                        Text("--")
                            .foregroundColor(.black)
                    } else {
                        Text(value)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                } else {
                    Text("--")
                        .foregroundColor(.black)
                }
                Image("eye")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.Blue)
            }
            Divider()
        }.padding(.bottom)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(.constant(Dummy.user))
    }
}
