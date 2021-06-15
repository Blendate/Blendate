//
//  HorizontalPickerView.swift
//  Blendate
//
//  Created by Michael on 6/3/21.
//

import SwiftUI

struct HorizontalPickerView<Content: View>:UIViewRepresentable {
    
    var content : Content
    //
    var pickerCount : Int
    @Binding var offSet : CGFloat
    
    init (count: Int,offset: Binding<CGFloat>,@ViewBuilder content: @escaping () -> Content){
        
        self.content = content()
        self._offSet = offset
        self.pickerCount = count
    }
    
    func makeCoordinator() -> Coordinator {
        return HorizontalPickerView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        
        
        // So Swiftui width will be total of pickercount X 20 + screen size
        
        let width  = CGFloat((pickerCount * 5) * 20) + (getRect().width - 30_)
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        swiftUIView.backgroundColor = .clear
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        return scrollView
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
    
    }
    
    //delegate
   
   class Coordinator : NSObject,UIScrollViewDelegate{
       
       var parent : HorizontalPickerView
       
       init(parent: HorizontalPickerView){
           self.parent = parent
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           parent.offSet = scrollView.contentOffset.x
       }
       
     
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           
           let offset = scrollView.contentOffset.x
           
           let value = ( offset / 20).rounded(.toNearestOrAwayFromZero)
           scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
       }
       func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           
           if !decelerate{
               let offset = scrollView.contentOffset.x
               
               let value = ( offset / 20).rounded(.toNearestOrAwayFromZero)
               scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
           }
       }
   }
}

func getRect() -> CGRect{
    return UIScreen.main.bounds
}
