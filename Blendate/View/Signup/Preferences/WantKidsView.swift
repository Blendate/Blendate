//
//  WantKidsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct WantKidsView: View {
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
                Text("Do you want more kids?")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .padding(.top, 65)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 150)
                
                HStack{
                    ItemButton(title: "Yes") {
                        user.familyPlans = .wantMore
                        next.toggle()
                    }.padding(.trailing)
                    
                    ItemButton(title:"No") {
                        user.familyPlans = .dontWant
                        next.toggle()
                    }
                }
                ItemButton(title:"Don't Care", width: 150) {
                    user.familyPlans = .dontWant
                    next.toggle()
                }.padding(.trailing)
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: WorkView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: true)
                                        }
                                    ).disabled(user.familyPlans == .none))
            .circleBackground(imageName: "Family", isTop: true)
    }
}

#if DEBUG
struct WantKids_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WantKidsView(true, .constant(Dummy.user))
        }
    }
}
#endif

