//
//  InterestedView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct InterestedView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var next: Bool = false
    let signup: Bool


    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Spacer()
                Text("Who are you interested in dating?")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack{
                    ItemButton(title: "Women", width: 136, active: user.seeking == .female) {
                        user.seeking = .female
                    }.padding()
                    ItemButton(title: "Men", width: 136, active: user.seeking == .male) {
                        user.seeking = .male
                    }
                }
                
                HStack{
                    ItemButton(title: "Both", width: 136, active: user.seeking == .nonBinary) {
                        user.seeking = .other
                    }
                    
                }
            }
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: RelationshipView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: true)
                                        }
                                    ).disabled(user.seeking == Gender.none))
            .circleBackground(imageName: "Interested", isTop: true)
    }
}


#if DEBUG
struct InterestedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InterestedView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
