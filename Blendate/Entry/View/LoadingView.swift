//
//  LoadingView.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI

enum SessionState {
    case noUser, user, loading
}

enum FirebaseState {
    case loading, noUser, uid(String)
}


struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.Blue
                .ignoresSafeArea()
            Image("IconR")
        }
    }
}

struct LoadingView<Content: View>: View {
    @State private var loadingText: [String] = "Loading your profile...".map({String($0)})
    @Binding var showLoading: Bool
    @State private var counter: Int = 0
        
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var color: Color = .Blue
    var content: Content
    
    init(showLoading: Binding<Bool>, _ color: Color = .Blue, _ text: String = "Loading your profile...", @ViewBuilder content: () -> Content){
        self._showLoading = showLoading
        self.color = color
        self.content = content()
        loadingText = text.map({String($0)})

    }

    var body: some View {
        ZStack {
            content
            ZStack {
                if showLoading {
                    ZStack {
                        let foreground: Color = color != .Blue ? Color.Blue:Color.white
                        color
                            .ignoresSafeArea()
                        Image("IconR")
            //                .tint(foreground)
                            .renderingMode(.template)
                            .foregroundColor(foreground)
                        ZStack {
                            HStack(spacing: 0){
                                ForEach(loadingText.indices) { index in
                                    Text(loadingText[index])
                                        .font(.headline)
                                        .fontWeight(.heavy)
                                        .foregroundColor(foreground)
                                        .offset(y: counter == index ? -5:0)
                                }
                            }
                        }.offset(y: 70)
                    }
                    .onReceive(timer) { _ in
                        withAnimation(.spring()) {
                            let lastIndex = loadingText.count - 1
                            if counter == lastIndex {
                                counter = 0
                            } else {
                                counter += 1
                            }
                        }
                    }
                        .transition(.opacity)
                }
            }.zIndex(2.0)
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(showLoading: .constant(true)) {
            
        }
    }
}
