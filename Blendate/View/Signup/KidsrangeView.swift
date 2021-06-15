//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct KidsRangeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let signup: Bool
    @State private var next = false
    
    @State private var showOnProfile = true
    @State var kidsRange: IntRange = IntRange(min: 0, max: 0)
    @Binding var user: User
    
    var active: Binding<Bool> { Binding (
        get: { user.childrenAge.min < user.childrenAge.max },
            set: { _ in }
        )
    }
    
    var minProxy: Binding<CGFloat> {
        Binding<CGFloat>(
            get: { CGFloat(user.childrenAge.min) },
            set: { user.childrenAge.min = Int($0) }
        )
    }
    
    var maxProxy: Binding<CGFloat> {
        Binding<CGFloat>(
            get: { CGFloat(user.childrenAge.max) },
            set: { user.childrenAge.max = Int($0) }
        )
    }
    
    func getValue(from:Int, index:CGFloat) -> String{
        let startWeight = from
        
        let progress = index / 20
        return "\(startWeight + (Int(progress * 0.2)))"
    }
    
    
    init(_ signup: Bool = false, _ user: Binding<User>){
        self.signup = signup
        self._user = user
    }
    
    var body: some View {
            VStack{
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
           
                ScrollView{VStack { Text("Children’s age range")
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
                    HorizontalPickerView(count: pickerCount, offset: minProxy) {
                        
                       
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
              
                            Text("\(pickerCount + 1)")
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
                        Text("\(getValue(from: 1, index: minProxy.wrappedValue))")
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
                        HorizontalPickerView(count: pickerCount, offset: maxProxy) {
                            
                           
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
                            Text("\(getValue(from: 1, index: maxProxy.wrappedValue))")
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
                Toggle("Show on Profile", isOn: .constant(true)).foregroundColor(.gray)
                    .padding()}}
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: LocationView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: true)
                                        }
                                    ))
            .circleBackground(imageName: "Family", isTop: true)
    }
}

#if DEBUG
struct KidsRangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            KidsRangeView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
