//
//  CommunityView.swift
//  Blendate
//
//  Created by Michael on 8/8/22.
//

import SwiftUI

class CommunityViewModel: ObservableObject {
    @Published var topics: [CommunityTopic] = []
    
    let service = CommunityService()
    
    init() {
        fetchTopics()
    }
    
    func fetchTopics(){
        service.collection
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print("Fetch Messages Error: \(error?.localizedDescription)")
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let topic = try? change.document.data(as: CommunityTopic.self){
                            self.topics.append(topic)
                        } else {
                            print("Decode Error For: \(change.document.documentID)")
                        }
                    }
                })
            }

    }
}

struct CommunityView: View {
    @StateObject var model = CommunityViewModel()
    @State var title: String = ""
    @State var text: String = ""
    @State var showNew = false
    
    var body: some View {
        NavigationView {
            VStack {
                header
                newDiscussion
                List {
                    ForEach(model.topics) { topic in
                        CommunityCell(topic: topic)
                            .listRowSeparator(.hidden)
                    }

                    
                }.listStyle(.plain)
            }
            .padding(.top, 10)
            .navigationBarHidden(true)
            .sheet(isPresented: $showNew) {
                NewCommunityView()
                .environmentObject(model)
            }
        }
    }
    
    var newDiscussion: some View {
        HStack {
            Button {
                showNew = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Start Discussion")
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .foregroundColor(.DarkBlue)
                .overlay(
                    Capsule()
                        .stroke(Color.DarkBlue, lineWidth: 1)
                )
            }
            Spacer()
        }
        .padding(.leading)
    }
    
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Community")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("See what other parents are saying")
            }
            Spacer()
            Button(systemName: "magnifyingglass") {
                
            }
            .font(.largeTitle)
            .fontWeight(.bold)
        }
        .padding(.horizontal)
        .foregroundColor(.DarkBlue)
    }
}

struct CommunityCell: View {
    let topic: CommunityTopic
    
    var body: some View {
        NavigationLink {
            CommunityChatView(topic: topic)
        } label: {
            VStack(alignment: .leading) {
                Text(topic.title)
                    .fontType(.semibold, .title3, .DarkBlue)
                HStack {
                    Circle().fill(Color.Blue).frame(width: 50)
                    Text(topic.subtitle)
                        .fontType(.regular, .body, .gray)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color.DarkBlue, lineWidth: 1)
            )
        }.buttonStyle(.plain)
    }

}

struct NewCommunityView: View {
    @EnvironmentObject var model: CommunityViewModel
    
    @State private var title = ""
    @State private var subtitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Finding the best nanny", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField("Discussion to help parents find the best nanny in their area", text: $subtitle, axis: .vertical)
                } header: {
                    Text("Description")
                }
            }.toolbar {
                ToolbarItem(placment: .navigationBarTrailing, systemImage: "plus") {
//                    guard let uid = try? Fire.checkUID() else {return}
//                    let cid = FirebaseManager.instance.Community.document().documentID
//                    let topic = CommunityTopic(title: title, subtitle: subtitle, cid: cid, author: uid)
//                    create(topic)
                }
            }
        }
    }
    
    private func create(_ topic: CommunityTopic){
//        do {
//            CommunityService().create(topic)
//            try FirebaseManager.instance.Community.document(topic.cid)
//                .setData(from: topic)
//        } catch {
//            print("Create Community Error: \(error.localizedDescription)")
//        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
