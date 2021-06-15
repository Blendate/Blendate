//////
//////  ProfileView.swift
//////  Blendate
//////
//////  Created by Michael Wilkowski on 1/14/21.
//////
////
////import SwiftUI
////
////enum ProfileType {
////    case myProfile
////    case dateProfile
////    case editProfile
////}
////
////struct ProfileVieww: View {
////    @Binding var user: User
////    let type: ProfileType
////
////    init(_ user: Binding<User>, _ type: ProfileType = .myProfile){
////        self.type = type
////        self._user = user
////    }
////
////    init(_ users: Binding<[User]>, _ type: ProfileType = .myProfile){
////        self.type = type
////        self._user = users[0]
////    }
////    var body: some View {
////        NavigationView {
////            ScrollView(.vertical) {
////                ZStack{
////                    VStack {
////                        FirebaseImageView(imageURL: user.coverPhoto)
////                            .frame(height: 360)
////                            .padding(.bottom, 100)
////                        about
////                        cards
////                        images
////                    }
////                    .padding(.bottom)
////                    ProfileCardView(user: $user, type: type)
////                        .padding().offset(y: -320)
////                }
////            }.edgesIgnoringSafeArea(.top)
////            .navigationBarTitle("")
////            .navigationBarHidden(true)
////        }
////    }
////
////    private let columns = [GridItem(.flexible()),
////                           GridItem(.flexible())
////                        ]
////
////    var about: some View {
////        VStack(alignment: .leading) {
////            Text("About")
////                .font(.title)
////                .bold()
////            Text(user.bio)
////                .lineLimit(0)
////        }.padding()
////    }
////
////    var images: some View {
////        VStack {
////            Text("My Gallery")
////                .font(.title)
////                .bold()
////            ScrollView(.horizontal) {
////                LazyHGrid(rows: columns, spacing: 10){
////                    ForEach(1..<7, id: \.self) { index in
////                        ZStack {
////                            Rectangle()
////                                .frame(width: 164, height: index % 2 == 0 ? 164:200)
////                                .foregroundColor(index % 2 == 0 ? .blue:.red)
////                                .cornerRadius(15)
////                            Text(String(index)).foregroundColor(.white)
////                        }
////
////                    }
////                }
////            }.padding()
////            .frame(height: 420)
////        }
////    }
////
////    var interests: some View {
////        VStack {
//////            Text("My Interests")
//////                .font(.title)
//////                .bold()
//////            ScrollView(.horizontal){
//////                LazyHGrid(rows: columns){
//////                    ForEach(user.interests, id: \.self) { interest in
//////                        Text(interest)
//////                            .foregroundColor(.DarkBlue)
//////                            .padding()
//////                            .padding(.horizontal)
//////                            .shadow(radius: 10)
//////                    }
//////                }
//////            }
////        }
////    }
////
////    var cards: some View {
////        ScrollView(.horizontal) {
////            HStack(alignment: .top, spacing: 15) {
////                InfoCard("Personal", $user)
////                InfoCard("Children", $user)
////                InfoCard("Background", $user)
////                InfoCard("Personal", $user)
////            }
////        }.padding()
////    }
////
////}
////
////
////
////
//struct InfoCards: View {
//
//    let title:String
//
//    @Binding var user: User
//
//    init(_ title: String, _ user: Binding<User>){
//        self.title = title
//        self._user = user
//    }
//
//    var body: some View {
//        VStack (alignment: .leading){
//            HStack {
//                Spacer()
//                Text(title)
//                    .font(.title3)
////                    .font(.system(size: 16))
//                    .fontWeight(.semibold)
//                switch title {
//                case "Personal":
//                    Image("smiley")
//                case "Children":
//                    Image("smiley_child")
//                case "Background":
//                    Image(systemName: "globe")
//                default:
//                    Image("smiley")
//                }
//                Spacer()
//            }//.padding()
//
//            switch title {
//            case "Personal":
//                if let status = user.relationship {
//                    InfoData("Divorced", status.rawValue)
//                }
//                if let plans = user.familyPlans {
//                    InfoData("Family Plans", plans.rawValue)
//                }
//                if let _ = user.height {
//                    InfoData("Height", user.feet())
//                }
//            case "Children":
//                if  user.children > 0 {
//                    InfoData("Has Children", String(user.children))
//                    InfoData("Children age", String("\(user.childrenAge.min) - \(user.childrenAge.max)"))
//                } else {
//                    InfoData("Has Children", "None")
//
//                }
//                if let plans = user.familyPlans {
//                    InfoData("Family Plans", plans.rawValue)
//                }
//            case "Background":
//                if let religion = user.religion {
//                    InfoData("Religion", religion.rawValue)
//                }
//                if let politics = user.familyPlans {
//                    InfoData("Family Plans", politics.rawValue)
//                }
//                if let ethnicity = user.ethnicity {
//                    InfoData("Height", ethnicity.rawValue)
//                }
//            default:
//                InfoData("Name", user.firstName)
//            }
//        }.padding()
//        .cornerRadius(20)
////        .overlay(
////            RoundedRectangle(cornerRadius: 10)
////                .stroke(Color.LightGray, lineWidth: 2)
////        )
//        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
//        .shadow(color: Color.pink.opacity(0.3), radius: 20, x: 0, y: 10)    }
//}
//
//struct InfoData: View {
//
//    let title: String
//    let data: String
//
//    init(_ title: String, _ data: String){
//        self.title = title
//        self.data = data
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(title)
//                .foregroundColor(Color.DarkBlue)
//                .font(.title3)
//            Text(data)
//                .font(.system(size: 14))
//                .fontWeight(.medium)
//                .foregroundColor(.gray)
//
//        }.padding(.bottom, 10)
//    }
//}
////
////#if DEBUG
////struct ProfileView_Previews: PreviewProvider {
////    static var previews: some View {
////        ProfileVieww(.constant(Dummy.user))
////    }
////}
////#endif
