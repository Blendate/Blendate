//
//  BirthdayView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct BirthdayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var session: Session

    let signup: Bool
    
    @State var isPickerOpen = false
//    @State var selectedDate = Date()
    @State var monthValue = "December"
    @State var dateValue = "21"
    @State var yearValue = "2021"
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Text("What is your Birthate?")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.Blue)
                    .padding(.top, 65)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: .center)
                
                Button(action: {
                    isPickerOpen = true
                }, label: {
                    HStack{
                        Spacer()
                               
                            ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white.opacity(0.8))
                                            .frame(width: 85, height: 50, alignment: .center)
                                            .shadow(radius: 1)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.white)
                                            .frame(width: 100, height: 40, alignment: .center)
                                            .shadow(radius: 2)
                                
                                Text(monthValue)
                                    .font(.custom("Montserrat-Regualr", size: 16))
                                    .foregroundColor(.Blue)
                                    }
                        
                        
                        Spacer()
                        ZStack{
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .frame(width: 45, height: 50, alignment: .center)
                                    .shadow(radius: 1)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 2)
                            
                            Text(dateValue)
                                .font(.custom("Montserrat-Regualr", size: 16))
                                .foregroundColor(.Blue)
                            }
                        Spacer()
                        
                     ZStack{
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .frame(width: 65, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 1)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 2)
                        
                        Text(yearValue)
                            .font(.custom("Montserrat-Regualr", size: 16))
                            .foregroundColor(.Blue)
                            }
                        Spacer()
                    }
                    .padding(.horizontal)
                })
                .padding(.top, 40)
               
               
                Spacer()
                if isPickerOpen{
                    DatePicker("", selection: $user.birthday,in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .overlay(Button(action: {
                            
                            
                               let formatter = DateFormatter()
                               formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
                             

                               formatter.dateFormat = "yyyy"
                               yearValue = formatter.string(from: user.birthday)
                               formatter.dateFormat = "MMMM"
                               monthValue = formatter.string(from: user.birthday)
                               formatter.dateFormat = "dd"
                               dateValue = formatter.string(from: user.birthday)
                            
                            isPickerOpen = false
                        }, label: {
                            Text("Done").bold()
                                .font(.custom("Montserrat-Regualr", size: 24))
                                .foregroundColor(.Blue)
                                
                        }), alignment: .bottom)
                        
                        .background(Rectangle()
                                        .fill(Color.white.opacity(0.9))
                                        .frame(width: UIScreen.main.bounds.width,  alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .ignoresSafeArea()
                        )
                }
                NavigationLink(
                    destination: GenderView(signup, $user),
                    label: {
                        NextButton(next: .constant(true), isTop: false)
            
                    }
                )}
            .onAppear{ setDate() }
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        presentationMode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: GenderView(signup, $user),
                                        label: {
                                            NextButton(next: .constant(true), isTop: false)
                                
                                        }
                                    ))
            .circleBackground(imageName: "Birthday", isTop: false)
    }
    
    func setDate(){
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
      

        formatter.dateFormat = "yyyy"
        yearValue = formatter.string(from: today)
        formatter.dateFormat = "MMMM"
        monthValue = formatter.string(from: today)
        formatter.dateFormat = "dd"
        dateValue = formatter.string(from: today)
        
        print("\(user.firstName)")
        print("\(user.gender)")


    }
}



#if DEBUG
struct BirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BirthdayView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
