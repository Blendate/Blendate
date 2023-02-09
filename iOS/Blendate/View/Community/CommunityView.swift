//
//  CommunityView.swift
//  Blendate
//
//  Created by Michael on 8/8/22.
//

import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var session: SessionViewModel
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
                    ForEach(model.fetched) { topic in
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
                .environmentObject(session)
            }
            .errorAlert(error: $model.alert)
            .background(bottom: false)
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
                .foregroundColor(.white)
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: 1)
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
        .foregroundColor(.white)
    }
}

struct CommunityCell: View {
    let topic: CommunityTopic
    
    var body: some View {
        NavigationLink {
            Text("Community Chat View")
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
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var session: SessionViewModel
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
                ToolbarItem(placement: .navigationBarTrailing){
                    AsyncButton(systemImageName: "plus") {
                        guard let uid = session.user.id else {return}
                        await model.newDiscussion(author: uid, title: title, description: subtitle)
                        dismiss()
                    }
                }

            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
