//
//  ChatBannerView.swift
//  Blendate
//
//  Created by Michael on 8/7/21.
//

import SwiftUI

struct ChatBannerView: View {
    
    var matchUser: MatchUser
    var dismiss: ()->Void
    
    
    var body: some View {
        HStack {
            Button(action: dismiss, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 20)
                    .foregroundColor(.DarkBlue)
            })
            .padding(.trailing)
            
            ZStack{
                Circle()
                    .stroke(Color.Blue,lineWidth: 2)
                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image("sample2")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                
            }
            
            VStack(alignment: .leading) {
                Text("\(matchUser.userPreferences?.firstName ?? "FirstName" + "\(matchUser.userPreferences?.lastName ?? "")")")
                    .font(.custom("Montserrat-Bold", size: 18))
                    .foregroundColor(Color.DarkBlue)
                Text(matchUser.presence)
                    .font(.custom("Montserrat-Regular", size: 12))
                    .foregroundColor(Color.DarkBlue)
                    .opacity(0.5)
            }
            Spacer()
            Button(action: {
            }, label: {
                VStack(spacing: 2) {
                    Circle()
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Circle()
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            })
        }
        .padding(.horizontal)    }
}

struct ChatBannerView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBannerView(matchUser: MatchUser(), dismiss: {})
    }
}
