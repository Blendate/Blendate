//
//  InterestsView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI
import RealmSwift

struct InterestsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var interests = RealmSwift.List<String>()

    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        
        VStack{
            VStack {
                Text("Interests")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 3)
                Text("Select your interests for better blending")
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(Color.white)
                    .opacity(0.7)
                    .frame(width: getRect().width * 0.6)
                
            }
            .multilineTextAlignment(.center)
            .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(.bottom)
            
            InterestsGridView(interests: $interests)
            Spacer()
        }
        .circleBackground(imageName: nil, isTop: true)
        .onAppear{
            self.interests = state.user?.userPreferences?.interests ?? RealmSwift.List<String>()

        }
        
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.interests.removeAll()
                state.user?.userPreferences?.interests.append(objectsIn: interests)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
//        if signup { next = true} else { self.mode.wrappedValue.dismiss()}

    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsView()
    }
}

struct InterestsGridView: View {
    @Binding var interests: RealmSwift.List<String>
    
    var body: some View {
        VStack{
            HStack{
                InterestRightView(title: "Travel", isSelected: interests.contains("Travel")) {
                    interests.tapItem("Travel")
                }
                InterestLeftView(title: "Child Care", isSelected: interests.contains("Child Care")) {
                    interests.tapItem("Travel")
                }
            }
            HStack{
                InterestRightView(title: "Entertainment", isSelected: interests.contains("Entertainment")){
                    interests.tapItem("Travel")
                }
                InterestLeftView(title: "Food", isSelected: interests.contains("Food")){
                    interests.tapItem("Travel")
                }
            }
            HStack{
                InterestRightView(title: "Entrepreneurship", isSelected: interests.contains("Entrepreneurship")) {
                    interests.tapItem("Travel")
                }
                InterestLeftView(title: "International Affair", isSelected: interests.contains("International Affair")) {
                    interests.tapItem("Travel")
                }
            }
            HStack{
                InterestRightView(title: "Art", isSelected: interests.contains("Art")) {
                    interests.tapItem("Travel")
                }
                InterestLeftView(title: "Sports", isSelected: interests.contains("Sports")) {
                    interests.tapItem("Travel")
                }
            }
            HStack{
                InterestRightView(title: "Identity", isSelected: interests.contains("Identity")) {
                    interests.tapItem("Travel")
                }
            }
        }
    }
}

struct InterestRightView: View {
    
    var title: String
    var isSelected : Bool
    var action: ()->Void

    
    var body: some View {
        Button(action: action) {
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                    .frame(width: getRect().width * 0.45, height: 90, alignment: .center)
                
                VStack{
                    Text(title)
                        .font(.custom("Montserrat-Bold", size: 16))
                        .foregroundColor(.DarkBlue)
                    
                    Text(InterestsDict[title]!)
                        .font(.custom("Montserrat-Regular", size: 12))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color.gray)
                    
                }
                .frame(width: getRect().width * 0.425, height: 85, alignment: .center)
            }
            .overlay(Image(isSelected ? "PlusCircle" : "MinusCircle")
                        .offset(x: -15, y: 25), alignment: .topLeading)
        }
    }
}


struct InterestLeftView: View {
    
    var title: String
    var isSelected : Bool
    var action: ()->Void

    var body: some View {
        
        Button(action: action) {
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(width: getRect().width * 0.45, height: 90, alignment: .center)
                
                
                VStack{
                    Text(title)
                        .font(.custom("Montserrat-Bold", size: 16))
                        .foregroundColor(.DarkBlue)
                    
                    Text(InterestsDict[title]!)
                        .font(.custom("Montserrat-Regular", size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.gray)
                    
                }
                .frame(width: getRect().width * 0.425, height: 85, alignment: .center)
            }
            .overlay(Image(isSelected ? "PlusCircle" : "MinusCircle")
                        .offset(x: 15, y: 25), alignment: .topTrailing)
        }
    }
}

struct InterestBubbleView: View {
    
    var title: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
                .frame(width: getRect().width * 0.45, height: 90, alignment: .center)
            VStack{
                Text(title)
                    .montserrat(.bold, 16)
                    .foregroundColor(.Blue)
                
                Text(InterestsDict[title] ?? "")
                    .montserrat(.regular, 12)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.gray)
            }
            .frame(width: getRect().width * 0.425, height: 85, alignment: .center)
        }
    }
}
