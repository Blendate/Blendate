//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI
import RealmSwift

struct KidsRangeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
//    @State var kidsRange: IntRange = IntRange(min: 0, max: 0)
    
//    @State var childAgeMin: Int = 0
//    @State var childAgeMax: Int = 1


    @State var minProxy: CGFloat = 0
    @State var maxProxy: CGFloat = 0
    
//    var minProxy: Binding<CGFloat> {
//        Binding<CGFloat>(
//            get: { CGFloat(childAgeMin) },
//            set: { childAgeMin = Int($0) }
//        )
//    }
    
//    var maxProxy: Binding<CGFloat> {
//        Binding<CGFloat>(
//            get: { CGFloat(childAgeMax) },
//            set: { childAgeMax = Int($0) }
//        )
//    }
    
    func getValue(from:Int, index:CGFloat) -> String{
        let startWeight = from
        
        let progress = index / 20
        let num = startWeight + (Int(progress * 0.2))
        if num == 19 {
            return "19+"
        } else {
            return "\(num)"
        }
    }
    
    func getNum(index: CGFloat)->Int{
        let progress = index / 20
        let num = 1 + (Int(progress * 0.2))
        return num
    }
    
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            ScrollView{VStack {
                Text("Children’s age range")
                .font(.custom("Montserrat-SemiBold", size: 28))
                .foregroundColor(.DarkBlue)
                .padding(.top, 65)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top, 250)
                
                let pickerCount = 18
                
                Group{
                    VStack {
                        Text("From")
                            .font(.custom("Montserrat-SemiBold", size: 18))
                            .foregroundColor(.DarkBlue)
                        HorizontalPickerView(count: pickerCount, offset: $minProxy) {
                            
                            
                            HStack(spacing: 0){
                                
                                ForEach(1...pickerCount, id:\.self){ index in
                                    
                                    Text("\(index)")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-SemiBold", size: 16))
                                        .frame(width:20)
                                    
                                    
                                    //subTick
                                    ForEach(1...4, id:\.self){ index in
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(width: 1, height: 15)
                                            // Gap b/w to line
                                            .frame(width:20)
                                    }
                                }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                
                                Text("19+")
                                    .foregroundColor(.gray)
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .frame(width:20)
                                    // Gap b/w to line
                                    .frame(width:20)
                            }
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            
                        }
                        .frame(height: 50)
                        .overlay(
                            Text("\(getValue(from: 1, index: minProxy))")
                                .font(.system(size: 38, weight: .heavy))
                                .foregroundColor(.purple)
                                .padding()
                                .background(
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(Color.white.opacity(0.9))
                                            .frame(width: 40, height: 62, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .shadow(radius: 2)
                                        
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .frame(width: 66, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .shadow(radius: 2)
                                    }
                                )
                        )
                        .padding()
                    }
                    VStack {
                        Text("To")
                            .font(.custom("Montserrat-SemiBold", size: 18))
                            .foregroundColor(.DarkBlue)
                        HorizontalPickerView(count: pickerCount, offset: $maxProxy) {
                            
                            
                            HStack(spacing: 0){
                                
                                ForEach(1...pickerCount, id:\.self){ index in
                                    
                                    Text(index == 19 ? "19+":"\(index)")
                                        .foregroundColor(.gray)
                                        .font(.custom("Montserrat-SemiBold", size: 16))
                                        .frame(width: index == 19 ? 30:20)
                                    
                                    
                                    //subTick
                                    ForEach(1...4, id:\.self){ index in
                                        
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(width: 1, height: 15)
                                            // Gap b/w to line
                                            .frame(width:20)
                                    }
                                }
                                
                                Text("\(pickerCount + 1)")
                                    .foregroundColor(.gray)
                                    .font(.custom("Montserrat-SemiBold", size: 16))
                                    .frame(width:20)
                                    // Gap b/w to line
                                    .frame(width:20)
                            }
                            //                        .background(Color("BG_Color"))
                            
                        }
                        .frame(height: 50)
                        .overlay(
                            Text("\(getValue(from: 1, index: maxProxy))")
                                .font(.system(size: 38, weight: .heavy))
                                .foregroundColor(.purple)
                                .padding()
                                .background(
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(Color.white.opacity(0.9))
                                            .frame(width: 40, height: 62, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .shadow(radius: 2)
                                        
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .frame(width: 66, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .shadow(radius: 2)
                                    }
                                )
                        )
                        .padding()
                    }
                }
                
            }
            
            }
            NavigationLink(
                destination: LocationView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
        }
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight:.infinity)
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: "Family", isTop: true)
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.childAgeMin = getNum(index: minProxy)
                state.user?.userPreferences?.childAgeMax = getNum(index: maxProxy)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

#if DEBUG
struct KidsRangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            KidsRangeView(true)
                .environmentObject(AppState())
        }
    }
}
#endif
