//
//  AgeRangeView.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI
import AudioToolbox


#warning("Fix Starting Value")
struct AgeRangeView: View {
    enum PickType { case age,range }
    
    @Binding var value: Int
    let type: PickType

    var max: Int { type == .age ? 13 : 22 }
    var spacing: CGFloat { AgeTick.spacing }
    
    var offset: Binding<CGFloat> {
        .init {
            let _value = value < 0 ? 0 : value
            return CGFloat(_value) * spacing
        } set: {
            value = 1 + Int($0 / spacing)
        }
    }
    
    var selected: Int {
        Int(offset.wrappedValue / AgeTick.spacing)
    }
    
    var selectedString: String {
        ageString(for: selected)
    }
    
    var body: some View {
        AgePicker(pickerCount: max, offset: offset) {
            HStack(spacing: 0){
                ForEach(1...max, id:\.self){ index in
                    AgeTick(string: ageString(for: index))
//                    AgeTick(type, index, offset: offset)
                }
            }
        }
        .frame(height: AgeTick.height)
        .overlay(
            Overlay(string: selectedString)
        )
        .padding()
        .onChange(of: offset.wrappedValue) { newValue in
            print(newValue)
            print(selected)
            print(selectedString)
        }
    }
    
    func ageString(for number: Int) -> String {
        if number == max {
            return String(max-1) + "+"
        } else {
            return String(number)
        }
    }
    
    struct Overlay: View {
        let string: String
        var body: some View {
            Text(string)
                .font(.title, .DarkBlue)
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 40, height: 62, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 2)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .frame(width: 66, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 2)
                    }
                )
        }
    }
    
//    func ageString(_ offset: CGFloat)->String {
//        let num = (1 + Int(offset / AgeTick.spacing))
//
//        if type == .age {
//            if num == 7 {
//                return "6+"
//            } else {
//                return String(num)
//            }
//        } else {
//            if num == 22 {
//                return "21+"
//            } else {
//                return String(num)
//            }
//        }
//    }
    
    
    struct AgeTick: View {
        static let height: CGFloat = 60
        static let spacing: CGFloat = 60
        static let width: CGFloat = 40
        
//        let index: Int
//        var indexString: String
//        @Binding var offset: CGFloat
        
        let string: String
//
//        init(_ type: PickType, _ index: Int, offset: Binding<CGFloat>){
//            self.index = index
//            if type == .age {
//                if index == 7 {
//                    indexString = "6+"
//                } else {
//                    indexString = String(index)
//                }
//            } else {
//                if index == 22 {
//                    indexString = "21+"
//                } else {
//                    indexString = String(index)
//                }
//            }
//            self._offset = offset
//
//        }
        
        var body: some View {
            Text(string)
                .foregroundColor(.DarkBlue.opacity(0.60))
                .frame(width: AgeTick.width, height: AgeTick.height)
                .frame(width:AgeTick.spacing)
        }
    }
    
    
    
    struct AgePicker<Content: View> : UIViewRepresentable {
        
        var content: Content
        
        @Binding var offset: CGFloat
        var pickerCount: Int
        
        init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()->Content){
            self.content = content()
            self._offset = offset
            self.pickerCount = pickerCount
        }
        
        func makeCoordinator() -> Coordinator {
            return AgePicker.Coordinator(parent: self)
        }
        
        func makeUIView(context: Context) -> UIScrollView {
            let scrollView = UIScrollView()
            let swiftUIView = UIHostingController(rootView: content).view!
            
            //        let dunno: CGFloat = 146
            //        let padding: CGFloat = 130
            //        let width = AgeTick.spacing// + dunno + padding
            let dunno = -40
            let width = CGFloat((pickerCount) * Int(AgeTick.spacing)) + (getRect().width - AgeTick.spacing + CGFloat(dunno))
            
            swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: AgeTick.height)
            
            scrollView.contentSize = swiftUIView.frame.size
            scrollView.addSubview(swiftUIView)
            scrollView.bounces = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = context.coordinator
            scrollView.backgroundColor = UIColor(.clear)
            swiftUIView.backgroundColor = .clear
            
            
            return scrollView
        }
        
        func updateUIView(_ uiView: UIScrollView, context: Context) {
            
        }
        
        class Coordinator: NSObject, UIScrollViewDelegate {
            var parent: AgePicker
            
            init(parent: AgePicker){
                self.parent = parent
            }
            
            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                parent.offset = scrollView.contentOffset.x
            }
            
            func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
                let offset = scrollView.contentOffset.x
                
                let value = (offset / AgeTick.spacing).rounded(.toNearestOrAwayFromZero)
                
                scrollView.setContentOffset(CGPoint(x: value * AgeTick.spacing, y: 0), animated: false)
                
                //            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                //            AudioServicesPlayAlertSound(1157)
                
            }
            
            func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
                if !decelerate {
                    let offset = scrollView.contentOffset.x
                    
                    let value = (offset / AgeTick.spacing).rounded(.toNearestOrAwayFromZero)
                    
                    scrollView.setContentOffset(CGPoint(x: value * AgeTick.spacing, y: 0), animated: false)
                    
                    //                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    //                AudioServicesPlayAlertSound(1157)
                }
            }
        }
    }
}
