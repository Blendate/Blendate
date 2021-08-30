//
//  HeightView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct HeightView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var height: Double = 0
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    @State var isSegue = false
    @State var selectedHeight = "4'0"
    let Heights = ["4'0", "4'1","4'2","4'3","4'4","4'5","4'6","4'7","4'8","4'9","5'0","5'1","5'2","5'3","5'4","5'5","5'6","5'7","5'8","5'9","6'0","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","7'0"]
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            Text("How tall are you?")
                .font(.custom("LexendDeca-Regular", size: 32))
                .foregroundColor(Color.white)
            HStack(spacing: 2) {
                
                Image("Height")
                    .resizable()
                    .frame(height: 360, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .scaledToFill()
                HStack{
                    //
                    VStack (spacing: 50) {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 25, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1)))
                            .frame(width: 75, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 25, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    Picker("", selection: $selectedHeight) {
                        
                        ForEach(Heights, id:\.self){ i in
                            
                            Text("""
                            \(i)"
                            """)
                                .foregroundColor(.Blue)
                                .font(.title2)
                                .bold()
                                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("")
                        }
                    }
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .frame(width: 70, height: 50)
                            
                            Text("""
                            \(selectedHeight)"
                            """)
                                .foregroundColor(.Blue)
                                .font(.title)
                                .bold()
                        }, alignment: .center)
                    .offset(x:10)
                    .frame(width: 50, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                }
            }
            .offset( y: getRect().height * 0.25)
            .frame(width: getRect().width * 0.8, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Please don’t exaggerate by too much")
                .montserrat(.semibold, 18)
                .foregroundColor(.DarkBlue)
                .padding(.bottom, 50)
            
            NavigationLink(
                destination: InterestedView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: nil)
        .onAppear {
            self.height = state.user?.userPreferences?.height ?? 0.0
        }
        
    }
    
    func stringToDouble(_ string: String)->Double{
        let replaced = string.replacingOccurrences(of: "'", with: ".")
        return Double(replaced)!
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.height = stringToDouble(selectedHeight)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}


#if DEBUG
struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeightView(true)
        }
    }
}
#endif
