////
////  LoadingView.swift
////  Blendate
////
////  Created by Michael on 4/1/22.
////
//
//import SwiftUI
//
//
//struct LoadingAnimationView: View {
//    let text: String
//    var font: Font = .title3
//    var color: Color = .white
//    var gradient: [Color] = []
//    var animate = true
////    @State private var textArray: [String] = "Loading your profile...".map{ String($0) }
//    @State private var counter: Int = 0
//    
////    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//
//    
//    var textArray: [String] { text.map{ String($0) } }
//    private var indices: [Int] { Array(textArray.indices) }
//    
//    var body: some View {
//        ZStack {
//            Image.Icon(size: 100, .white)
//            HStack(spacing: 0){
//                ForEach(indices, id: \.self) { index in
//                    Text(textArray[index])
//                        .font(font)
//                        .fontWeight(.heavy)
//                        .foregroundColor(color)
//                        .offset(y: counter == index ? -5:0)
//
//                }
//            }
//            .offset(y: 70)
//        }
//        .foregroundGradient(gradient, animate: animate)
////        .onReceive(timer) { _ in
//        .onAppear{
//            withAnimation(.spring()) {
//                let lastIndex = text.count - 1
//                if counter == lastIndex { counter = 0 }
//                    else { counter += 1 }
//            }
//        }
//        .transition(.opacity)
//    }
//}
//
//extension View {
//    func foregroundGradient(_ colors: [Color], animate: Bool = true) -> some View {
//        modifier(GradientMask(colors: colors, animate: animate, animating: animate))
//    }
//}
//
//struct GradientMask: ViewModifier {
//    let colors: [Color]
//    let animate: Bool
//    @State var animating: Bool
//    
//    var gradient: LinearGradient {
//        LinearGradient(colors: colors, startPoint: animate ? .trailing : .leading, endPoint: animate ? .leading : .trailing)
//
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .overlay {
//                gradient
//                .mask(content)
//            }
//        .onAppear {
//            if animate {
//                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
//                    animating.toggle()
//                }
//            }
//
//        }
//    }
//}
//
//
//struct LoadingView<Content: View, Background:View>: View {
//    let loading: Bool
//    var text: String = "Loading your profile..."
//    var color: Color = .Blue
//    var foreground: Color = .white
//    var background: Background
//    @ViewBuilder var content: Content
//    
//    var body: some View {
//        if loading {
//            ZStack {
//                content
//                ZStack {
//                    background.ignoresSafeArea()
//                    LoadingAnimationView(text: text)
//                }.zIndex(2.0)
//            }
//        } else {
//            content
//        }
//    }
//}
//
//extension LoadingView {
//    init(_ loading: Bool,
//         color: Color = .Blue,
//         text: String = "Loading your profile...",
//         background: Background = Color.Blue,
//         content:Content = EmptyView()
//    ){
//        self.loading = loading
//        self.text = text
//        self.color = color
//        self.content = content
//        self.background = background
//    }
//}
//
//
//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(true, background: Color.Blue)
//        LoadingView(true, background: LoadingGradient())
//
//        LoadingAnimationView(text: "Loading your profile...")
//            .previewDisplayName("Animation View")
//    }
//}
//struct LoadingGradient: View {
//    @State private var animate = true
//    var body: some View {
//        LinearGradient(colors: [.Blue, .Purple], startPoint: animate ? .topLeading : .bottomLeading, endPoint: animate ? .bottomTrailing : .topTrailing)
//            .ignoresSafeArea()
//            .onAppear {
//                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
//                    animate.toggle()
//                }
//            }
//    }
//}
