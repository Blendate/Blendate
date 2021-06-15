//
//  ProfileView.swift
//  Blendate
//
//  Created by Michael on 6/1/21.
//

import SwiftUI



struct ProfileView: View {
    @Binding var user: User
    var type: ProfileType
    @State var editTapped = false
    
    init(_ user: Binding<User>, _ type: ProfileType = .myProfile){
        self._user = user
        self.type = type
    }
    
    init(_ users: Binding<[User]>, _ type: ProfileType = .dateProfile){
        self._user = users[0]
        self.type = type
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment:.leading) {
                    // Cover Card
                    VStack {
                        FirebaseImageView(imageURL: user.coverPhoto)
                            .frame(height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                            .zIndex(0)
                    }.overlay(
                        ProfileCardView(user: $user, type: type, editTapped: $editTapped)
                            .padding(.horizontal)
                            .offset(x: 0, y: 200), alignment: .bottom
                    )
                    if editTapped {
                        EditProfile($user)
                            .padding(.top,90)
//                        Text("Edit Area")
//                            .padding(.top, 90)

                    } else {
                    // About
                    VStack(alignment:.leading){
                        Text("About \(user.firstName)")
                            .font(.custom("LexendDeca-Regular.", size: 18))
                            .padding(.top, 90)
                            .padding(.bottom)
                        Text(user.bio)
                            .font(.custom("LexendDeca-Regular.", size: 16))
                            .foregroundColor(.accentColor)
                            .frame(width:300, alignment: .center)
                    }.padding()
                    // Info Cards
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        VStack{
                            HStack(alignment:.top){
                                InfoCard(.personal, user)
                                InfoCard(.children, user)
                                InfoCard(.background, user)
                                InfoCard(.lifestyle, user)

                            }.padding(.horizontal)
                            Spacer()
                        }
                    }).padding(.vertical)
                    // Profile Images
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        VStack{
                            HStack{
                                ImageCollectionView()
                                ImageCollectionView_2()
                                ImageCollectionView()
                            }
                        }
                    })
                    .padding()
                    interests
                    ExtraSpacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    var interests: some View {
        VStack(alignment:.leading){
            Text("Interests")
                .font(.custom("LexendDeca-Regular.", size: 18))
            HStack{
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4)
                    VStack{
                        Text("Travel")
                            .font(.custom("LexendDeca-Regular.", size: 16))
                            .foregroundColor(.accentColor)
                            .padding(.top)
                        Text("Kid Friendly Hotels, Travel Advice, Travel Accessories For Kids")
                            .font(.custom("LexendDeca-Regular.", size: 10))
                            .foregroundColor(.gray)
                            .frame(width: 160, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4)
                    VStack{
                        Text("Art")
                            .font(.custom("LexendDeca-Regular.", size: 16))
                            .foregroundColor(.accentColor)
                        Text("Theater, Interior Design, Craft Art, Dance, Fashion")
                            .font(.custom("LexendDeca-Regular.", size: 10))
                            .foregroundColor(.gray)
                            .frame(width: 140, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
            
            HStack{
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4)
                    VStack{
                        Text("Entertainment")
                            .font(.custom("LexendDeca-Regular.", size: 16))
                            .foregroundColor(.accentColor)
                        Text("Movies, Music, Gaming, Podcasts, Celebrities")
                            .font(.custom("LexendDeca-Regular.", size: 10))
                            .foregroundColor(.gray)
                            .frame(width: 140, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.45, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4)
                    VStack{
                        Text("Food")
                            .font(.custom("LexendDeca-Regular.", size: 16))
                            .foregroundColor(.accentColor)
                        Text("Picky Eaters, Healthy Recipes, Veganism, Vegetarianism ")
                            .font(.custom("LexendDeca-Regular.", size: 10))
                            .foregroundColor(.gray)
                            .frame(width: 140, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }

}

struct ExtraSpacer: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}
struct ProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(.constant(Dummy.user))
            .previewDevice("iPhone 8")
        
        ProfileView(.constant(Dummy.user))
            .previewDevice("iPhone 11")
    }
}

struct ImageCollectionView: View {
    var body: some View {
        VStack{
            
            ZStack{
                FirebaseImageView(imageURL: "")
//                Image("sample1")
//                    .resizable()
//                    .scaledToFill()
                    .frame(width: 162, height: 213, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("#myLove")
                    .font(.custom("LexendDeca-Regular.", size: 10))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Capsule()
                                    .fill(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1))))
                    .offset(x: -40, y: -80)
            }
            
            ZStack{
                FirebaseImageView(imageURL: "")
//                Image("sample2")
//                    .resizable()
//                    .scaledToFill()
                    .frame(width: 162, height: 171, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("#myLove")
                    .font(.custom("LexendDeca-Regular.", size: 10))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Capsule()
                                    .fill(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1))))
                    .offset(x: -40, y: -60)
                
            }
            
        }
    }
}


struct ImageCollectionView_2: View {
    var body: some View {
        VStack{
            
            ZStack{
                FirebaseImageView(imageURL: "")
//                Image("sample3")
//                    .resizable()
//                    .scaledToFill()
                    .frame(width: 162, height: 171, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("#myLove")
                    .font(.custom("LexendDeca-Regular.", size: 10))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Capsule()
                                    .fill(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1))))
                    .offset(x: -40, y: -60)
                
            }
            
            ZStack{
                FirebaseImageView(imageURL: "")

//                Image("sample4")
//                    .resizable()
//                    .scaledToFill()
                    .frame(width: 162, height: 213, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("#myLove")
                    .font(.custom("LexendDeca-Regular.", size: 10))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Capsule()
                                    .fill(Color(#colorLiteral(red: 0.1420793831, green: 0.256313622, blue: 0.69624722, alpha: 1))))
                    .offset(x: -40, y: -80)
            }
            
        }
    }
}



