//
//  ChatRoomView.swift
//  Blendate
//
//  Created by Michael on 7/6/21.
//

import SwiftUI
import RealmSwift

func addDay(_ int: Int)->Date{
    return Calendar.current.date(byAdding: .day, value: int, to: Date())!
}


struct ChatRoomView: View {
    @ObservedResults(User.self) var users
    @EnvironmentObject var state: AppState

    @State var next = false
    @State var matchUser = MatchUser()
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("New Blends")
                    .lexendDeca(.regular, 28)
                    .foregroundColor(Color.DarkBlue)
                matches
                messageDivider
                messages
                Spacer()
            }
            .offset(y: -60)
            .onAppear {
                print("Conversations: \( users[0].conversations.count )")
            }
        }
    }

    var matches: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 20){
                
                ForEach(0 ... 3, id:\.self){ i in
                    
                    ZStack{
                        Circle()
                            .stroke(i % 2 == 0 ? Color.DarkBlue : Color.purple,lineWidth: 2)
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Image("sample2")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(Circle())
                        
                    }
                    
                }
            }
            .padding(20)
        }
        .frame(height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
    
    var messages: some View {
        ScrollView{
            VStack{
                if let conversations = users[0].conversations {
                    ForEach(conversations) { conversation in
                        NavigationLink(
                            destination: ChatView2(conversation, matchUser)
                                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "conversation=\(conversation.id)")) ,
                            label: {
                                BlendCellView(conversation: conversation, matchUser: $matchUser)
                                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "all-users=all-the-users"))

                            })
                    }
                }

            }
        }.padding(.horizontal)

    }
    
    var messageDivider: some View {
        VStack(spacing:0){
            HStack{
                Text("Messages")
                    .font(.custom("LexendDeca-Regular", size: 28))
                    .foregroundColor(Color.DarkBlue)
//
//                Text("10")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Circle()
//                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.DarkBlue, Color(#colorLiteral(red: 0.6895270944, green: 0.4312193692, blue: 0.8058347106, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
//                                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                
            }
            
            Rectangle()
                .fill(Color.DarkBlue)
                .frame(width: getRect().width * 0.9, height: 1)
        }
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView()
    }
}

struct BlendCellView: View {
    @ObservedResults(MatchUser.self) var matchUsers
    @EnvironmentObject var state: AppState
    let conversation: Conversation
    
    @Binding var matchUser: MatchUser
    
    
    var chatMembers: [MatchUser] {
        var matchUserList = [MatchUser]()
        for member in conversation.members {
            matchUserList.append(contentsOf: matchUsers.filter("identifier = %@", member.identifier))
        }
        return matchUserList
    }
    var body: some View {
        VStack {
            HStack{
                ForEach(chatMembers){ matchUser in
                    if matchUser.identifier != state.user?.identifier {
                        UserAvatarView(photo: matchUser.userPreferences?.profilePhoto, online: true)
                    }
                }
                VStack(alignment: .leading) {
                    Text("\(matchUser.userPreferences?.firstName ?? "FirstName" + "\(matchUser.userPreferences?.lastName ?? "")")")
                        .font(.custom("Montserrat-Semibold", size: 16))
                        .foregroundColor(Color.black)
//                    Text(conversation.lastMessage)
//                        .font(.custom("Montserrat-Regular", size: 12))
//                        .foregroundColor(Color.DarkBlue)
//                        .opacity(0.5)
                }.padding(.leading)
                
                Spacer()
                if conversation.unreadCount > 0 {
                    Text("\(conversation.unreadCount)")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.DarkBlue, Color(#colorLiteral(red: 0.6895270944, green: 0.4312193692, blue: 0.8058347106, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))

                }
//                if inbox.isRead {
//                    Text("")
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Circle()
//                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.DarkBlue, Color(#colorLiteral(red: 0.6895270944, green: 0.4312193692, blue: 0.8058347106, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
//                                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
//                }
//                else{
//                    if inbox.isRead{
//                        Image("read")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .scaledToFill()
//                    }
//                }
//
                
                
            }
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .frame(width: getRect().width * 0.9, height: 0.5)
            
            
        }.padding([.top, .leading, .trailing])
        .onAppear {
            for i in matchUsers {
                if i.identifier != self.state.user?.identifier {
                    matchUser = i

                }
            }
        }
    }
}

struct UserAvatarView: View {
    let photo: Photo?
    let online: Bool
    var action: () -> Void = {}
    
    private enum Dimensions {
        static let imageSize: CGFloat = 50
        static let buttonSize: CGFloat = 40
        static let cornerRadius: CGFloat = 50.0
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                image
                    .cornerRadius(Dimensions.cornerRadius)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        OnOffCircleView(online: online)
                    }
                }
            }
        }
        .frame(width: Dimensions.buttonSize, height: Dimensions.buttonSize)
    }
    
    var image: some View {
        Group<AnyView> {
            if let image = photo {
                return AnyView(ThumbnailPhotoView(photo: image, imageSize: Dimensions.imageSize))
            } else {
                return AnyView(BlankPersonIconView().frame(width: Dimensions.imageSize, height: Dimensions.imageSize))
            }
        }
    }
}

struct OnOffCircleView: View {
    let online: Bool
    
    private enum Dimensions {
        static let frameSize: CGFloat = 14.0
        static let innerCircleSize: CGFloat = 10
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: Dimensions.frameSize, height: Dimensions.frameSize)
            Circle()
                .fill(online ? Color.green : Color.red)
                .frame(width: Dimensions.innerCircleSize, height: Dimensions.innerCircleSize)
        }
    }
}

struct ThumbnailPhotoView: View {
    let photo: Photo
    var imageSize: CGFloat = 64
    
    var body: some View {
        let mugShot = UIImage(data: photo.thumbNail!)
        Image(uiImage: mugShot ?? UIImage())
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageSize, height: imageSize)
    }
}

struct BlankPersonIconView: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .foregroundColor(.gray)
    }
}
