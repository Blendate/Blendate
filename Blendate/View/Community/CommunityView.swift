//
//  CommunityView.swift
//  Blendate
//
//  Created by Michael on 7/6/21.
//

import SwiftUI

enum AccountType: String {
    case dating = "Dating"
    case community = "Community"
    case both = "Both"
}

struct CommunityView: View {
    
    @State var accountType: AccountType = .dating
    @State var isSegue = false
    
    var body: some View {
        VStack{
            VStack {
                Text("Here to find a relationship or community?")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                    .foregroundColor(.DarkBlue)
                    .padding(.bottom, 3)
                Text("Choose which kind of profile you’d like to make")
                    .font(.custom("Montserrat-Regular", size: 14))
                    .foregroundColor(.DarkBlue)
                    .opacity(0.7)
                    .frame(width: getRect().width * 0.5)
                  
            }
            .multilineTextAlignment(.center)
            .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(.bottom)
            

            HStack(spacing:20) {
                CommunityOptionButtonView(accountType: $accountType, title: .dating)
                CommunityOptionButtonView(accountType: $accountType, title: .community)
                CommunityOptionButtonView(accountType: $accountType, title: .both)
            }
            
            Text("You can change this later on in your Settings")
                .font(.custom("Montserrat-Regular", size: 14))
                .foregroundColor(.accentColor)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .padding(3)
            Spacer()
        }
        .circleBackground(imageName: "Family", isTop: false)
                       
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}

struct CommunityOptionButtonView: View {
    
    @Binding var accountType: AccountType
    var title: AccountType
//    var action: ()->()
    var body: some View {
//            Button(action: {action()}, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.white)
                        .frame(width: 112, height: 188, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    VStack{
                        Text(title.rawValue)
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundColor(.DarkBlue)
                        
                        Text(description())
                            .font(.custom("Montserrat-Regular", size: 14))
                            .foregroundColor(.DarkBlue)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        
                        Image(selected() ? "circle_check" : "circle_uncheck")
                    }
                }
                .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .stroke(Color.DarkBlue,lineWidth: 4))
//            }).padding(.trailing)
    }
    
    func description()->String {
        switch accountType {
        case .dating:
            return "Connect and Blend with other singles nearby"
        case .community:
            return "Discuss topics with other parents"
        case .both:
            return "Create one account for both platforms"

        }
    }
    
    
    func selected()->Bool {
        return accountType == title
    }
}

