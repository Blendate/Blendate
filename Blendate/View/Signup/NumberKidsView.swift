//
//  NumbersView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct NumberKidsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @EnvironmentObject var session: Session
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    @State var offset : CGFloat = 0
    @State var numberOfKids : CGFloat = 0
    
    var active: Binding<Bool> { Binding (
        get: { user.children > 0 },
            set: { _ in }
        )
    }
    
    var kidsProxy: Binding<CGFloat> {
        Binding<CGFloat>(
            get: { CGFloat(user.children) },
            set: { user.children = Int($0) }
        )
    }
    
    var body: some View {
            VStack(spacing: 15){
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
           
                Text("How many kids do you have?")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .padding(.top, 65)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 150)
                
                let pickerCount = 5
                            
                HorizontalPickerView(count: pickerCount, offset: $numberOfKids) {
                    
                   
                    HStack(spacing: 0){
                        
                        ForEach(1...pickerCount, id:\.self){ index in
                            
                            Text("\(index)")
                                .foregroundColor(.gray)
                                .font(.custom("Montserrat-SemiBold", size: 16))
                                .frame(width:30)
                            
                            
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
                    Text("\(getValue(from: 1, index: numberOfKids))")
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
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: KidsRangeView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: true)
                                        }
                                    ))
            .circleBackground(imageName: "Family", isTop: true)
    }
    
    func getWeight(from:Int) -> String{
        let startWeight = from
        
        let progress = offset / 20
        return "\(startWeight + (Int(progress * 0.2)))"
    }
    
    func getWeight1(from:Int) -> String{
        let startWeight = from
        
        let progress = numberOfKids / 20
        return "\(startWeight + (Int(progress * 0.2)))"
    }
    
    func getValue(from:Int, index:CGFloat) -> String{
        let startWeight = from
        
        let progress = index / 20
        return "\(startWeight + (Int(progress * 0.2)))"
    }

}
    
//    var body: some View {
//            VStack {
//                SVGView(.kidsAmount)
//                ZStack {
//                    ColorGradient
//                        .cornerRadius(15)
//                    VStack {
//                        Text("How many kids do you have?")
//                            .bold()
//                            .blendFont(36, .white)
//                            .multilineTextAlignment(.center)
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 30){
//                                ForEach(1..<12){ i in
//                                    if i == kids {
//                                        Text(String(i))
//                                            .blendFont(32, .Blue)
//                                            .padding()
//                                            .background(Color.white)
//                                            .cornerRadius(15)
//                                    } else {
//                                        Text(String(i))
//                                            .blendFont(32, .white)
//                                            .padding()
//                                            .onTapGesture {
//                                                session.user.children = i
//                                                kids = i
//                                            }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }.padding()
//            }.onAppear {
//                self.kids = session.user.children
//            }
//        }
//}

#if DEBUG
struct NumberKidsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NumberKidsView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
