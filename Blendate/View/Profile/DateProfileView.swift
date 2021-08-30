////
////  ProfileView.swift
////  Blendate
////
////  Created by Michael on 6/1/21.
////
//
//import SwiftUI
//import RealmSwift
//
//class LineupViewModel : ObservableObject {
//    @Published var lineup: [MatchUser] = [MatchUser()]
//
//    func shuffle() {
//        lineup.shuffle()
//        lineup.swapAt(0, 1)
//        //or listData = dictionary.shuffled().prefix(upTo: 10)
//    }
//}
//struct DateProfileView: View {
//    @EnvironmentObject var state: AppState
//    @ObservedResults(MatchUser.self) var matchUsers
//    @ObservedObject var vM = LineupViewModel()
//
//
//    @State var editTapped = false
//    @State var editType: EditType = .About
//    
//    @State var index: Int = 0
//    
//    init(index: Int = 0){
//        self.index = index
//    }
//    
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                coverPhoto
//                if editTapped {
//                    editView
//                } else {
//                    about
//                    infoCards
//                    photos
//                    interests
//                }
//            }
//            .background(Color.LightPink)
//            .edgesIgnoringSafeArea(.top)
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
//            .onAppear {
//                print("MatchUsers: \(matchUsers.count)")
////                getMatchUsers()
////                print("Lineup: \(vM.lineup.count)")
//            }
//        }
//    }
//    
//
//    
//    var coverPhoto: some View {
//        ZStack {
//            if let picture = matchUsers.first?.userPreferences?.coverPhoto?.picture,
//                let image = UIImage(data: picture) {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: UIScreen.main.bounds.width, height: 250)
//            }
//
//            ProfileCardView(type: .dateProfile, editTapped: $editTapped, editType: $editType, matchUser: matchUsers[0], index: $index)
//                .offset(y: UIScreen.main.bounds.height * 0.35 - 175)
//                .padding(.horizontal)
//                .environment(\.realmConfiguration, app.currentUser!.configuration(
//                                partitionValue: "all-users=all-the-users"))
//
//            
//        }.padding(.bottom, 90)
//        
//    }
//    
//    
//    var editView: some View {
//        Group {
//            switch editType {
//            case .About:
//                EditProfile()
//            case .Photos:
//                EditPhotos()
//            case .Interests:
//                EditInterests()
//            }
//        }
//    }
//    var about: some View {
//        VStack(alignment:.leading){
//            if !(matchUsers[index].userPreferences?.bio.isEmpty ?? false) {
//                VStack {
//                    HStack {
//                        Text("About \(matchUsers.first?.userPreferences?.firstName ?? "Name")")
//                            .lexendDeca(.regular, 18)
//                            .padding()
//                        Spacer()
//                    }
//                    Text(matchUsers.first?.userPreferences?.bio ?? "")
//                        .lexendDeca(.regular, 16)
//                        .multilineTextAlignment(.leading)
//                        .foregroundColor(.Blue)
//                        .padding([.horizontal, .bottom])
//                        .fixedSize(horizontal: false, vertical: true)
//                }
//                .background(RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.white)
//                                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5))
//            }
//        }.padding(.horizontal)
//    }
//    
//    var infoCards: some View {
//        
//        ScrollView(.horizontal, showsIndicators: false, content: {
//            if let user = matchUsers.first {
//                VStack{
//                    HStack(alignment:.top){
//                        if showPersonal() { InfoCard(.personal, user.userPreferences) }
//                        if showChildren() { InfoCard(.children, user.userPreferences) }
//                        if showBackground() { InfoCard(.background, user.userPreferences) }
//                        if showLifestyle() { InfoCard(.lifestyle, user.userPreferences) }
//                    }.padding(.horizontal)
//                    Spacer()
//                }.padding(.vertical)
//            }
//        })
//    }
//    
//    var photos: some View {
//        ScrollView(.horizontal, showsIndicators: true, content: {
//            VStack{
//                HStack{
//                    VStack{
//                        if let photo1 = matchUsers.first?.userPreferences?.photo1 {
//                            PhotoView(photo: .constant(photo1), title: "#myLove", large: true)
//                        }
//                        if let photo2 = matchUsers.first?.userPreferences?.photo2 {
//                            PhotoView(photo: .constant(photo2), title: "#myLove", large: false)
//                        }
//                    }
//                    VStack{
//                        if let photo3 = matchUsers.first?.userPreferences?.photo3 {
//                            PhotoView(photo: .constant(photo3), title: "#myLove", large: false)
//                        }
//                        if let photo4 = matchUsers.first?.userPreferences?.photo4 {
//                            PhotoView(photo: .constant(photo4), title: "#myLove", large: true)
//                        }
//                    }
//                    VStack{
//                        if let photo5 = matchUsers.first?.userPreferences?.photo5 {
//                            PhotoView(photo: .constant(photo5), title: "#myLove", large: true)
//                        }
//                        if let photo6 = matchUsers.first?.userPreferences?.photo6 {
//                            PhotoView(photo: .constant(photo6), title: "#myLove", large: false)
//                        }
//                    }
//                }
//            }
//        })
//        .padding()
//    }
//    
//    let layout = [
//        GridItem(.adaptive(minimum: getRect().width * 0.425), spacing: 10)
//    ]
//    var interests: some View {
//        
//        LazyVGrid(columns: layout, spacing: 10){
//            ForEach(matchUsers.first?.userPreferences?.interests ?? RealmSwift.List<String>(), id:\.self){ interest in
//                InterestBubbleView(title: interest)
//            }
//        }.padding()
//    }
//    
//    
//    func showPersonal()->Bool {
//        if matchUsers.first?.userPreferences?.relationship == nil && ((matchUsers.first?.userPreferences?.workTitle.isEmpty) != nil) && ((matchUsers.first?.userPreferences?.schoolTitle.isEmpty) != nil) {
//            return false
//        } else {return true}
//    }
//    
//    func showChildren()->Bool {
//        if !(matchUsers.first?.userPreferences?.isParent ?? false) && matchUsers.first?.userPreferences?.familyPlans == nil {
//            return false
//        } else {return true}
//    }
//    
//    func showBackground()->Bool {
//        if matchUsers.first?.userPreferences?.religion == nil && matchUsers.first?.userPreferences?.politics == nil && matchUsers.first?.userPreferences?.ethnicity == nil {
//            return false
//        } else {return true}
//    }
//    
//    func showLifestyle()->Bool {
//        if matchUsers.first?.userPreferences?.mobility == nil {
//            return false
//        } else {return true}
//    }
//    
//    func getMatchUsers(){
//        for i in 0...10 {
//            if i > matchUsers.count - 1 {
//                break
//            }
//            if matchUsers[i] != nil {
//                if matchUsers[i].identifier != self.state.user!.identifier {
//                    vM.lineup.append(matchUsers[i])
//                }
//            }
//        }
//    }
//}
//
//struct DateProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        DateProfileView()
//            .environmentObject(AppState())
//    }
//}
