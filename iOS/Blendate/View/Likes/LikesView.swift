//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI

struct LikesView: View {
    @EnvironmentObject var session: SessionViewModel
    
    var likes: [String] = []
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if !likes.isEmpty {
            TodayView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(likes, id: \.self) { uid in
                        VStack {
                            
                        }.frame(height: 200)
                            .background(Color.Blue)
                    }
                }
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(likes: ["1234"])
        LikesView()

    }
}
