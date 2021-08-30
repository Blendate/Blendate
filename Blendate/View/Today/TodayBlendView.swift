//
//  TodayBlendView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI
import RealmSwift

struct TodayBlendView: View {
    @EnvironmentObject var state: AppState
    @ObservedResults(MatchUser.self) var matchUsers
    
    @State var todayUser: MatchUser? = MatchUser()
    @State var message: String = ""
//    @State var loadUser = false

    var body: some View {
        VStack{
            Text("Today's Blend")
                .blendFont(42, .white)
                .padding(50)
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.white)
                        .frame(width: getRect().width * 0.9, height: getRect().width * 0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    VStack {
                        Text(todayUser?.userPreferences?.fullName() ?? "Full Name")
                            .font(.custom("Montserrat-Bold", size: 24))
                            .foregroundColor(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1)))
                        Text("Send a short message and start chating!")
                            .font(.custom("Montserrat-Regular", size: 12))
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        TextView(text: $message)
                            .frame(width: getRect().width * 0.7, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.gray))
                    }
                }
                .frame(width: getRect().width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    ZStack {
                        Circle()
                            .stroke(Color(UIColor(red: 0.757, green: 0.334, blue: 0.863, alpha: 1)), lineWidth: 6)
                            .frame(width: 140, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        PhotoView(photo: .constant(todayUser?.userPreferences?.profilePhoto), large: true)
                            .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    .offset(y: -180)
                    , alignment: .top)

                .overlay(
                    SaveConversationButton(members: [todayUser?.identifier ?? ""]){
                        
                    }
                    .environment(\.realmConfiguration, UserConfig())
                    , alignment: .bottom)
                
            }
            .offset(y: getRect().height * 0.175)
            
            .padding()
            Spacer()
        }.background(
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 0.188, green: 0.333, blue: 0.8, alpha: 1)), Color(UIColor(red: 0.816, green: 0.479, blue: 0.871, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            self.todayUser = matchUsers.filter{$0.identifier != self.state.user?.identifier}.randomElement()
        }
        
    }
}

struct TodayBlendView_Previews: PreviewProvider {
    static var previews: some View {
        TodayBlendView()
            .environmentObject(AppState())
    }
}
