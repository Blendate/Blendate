//
//  HeightView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct HeightView: View {
    @Binding var height: Int
    var isFilter: Bool = false

    func stringToDouble(_ string: String)->Double{
        let replaced = string.replacingOccurrences(of: "'", with: ".")
        return Double(replaced)!
    }


    @State var offset: CGFloat = 0
    var body: some View {
        VStack(spacing: 0) {
            SignupTitle(.height, isFilter)
            ZStack {
                HStack {
                    Image("Height")
                        .resizable()
                        .frame(width: getRect().width / 1.4, height: getRect().height / 2, alignment: .leading)
                        .padding(.top, 40)
                    Spacer()
                }
                HeightTicks(offset: $offset)

                HStack {
                    Spacer()
                    Text("\(getHeight())")
                        .fontType(.semibold, 28, .DarkBlue)
                        .padding(10)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.trailing, 10)
    //                        .fixedSize()
                        .frame(width: 105)
                }
            }

            Text("Please don’t exaggerate by too much")
                .fontType(.regular, 14, .white)
                .padding(.vertical, 50)
        }
        .onChange(of: offset) { newValue in
            height = offsetToInches(newValue)
        }
    }

    
    func getHeight()->String{
        let startHeight = 58
        let progress = offset / HeightTick.spacing
        
        let heightInches = startHeight + Int(progress)
//        return "\(startHeight + (Int(progress) * 1))"
        let feet = Measurement(value: Double(heightInches), unit: UnitLength.inches).converted(to: .feet)

        return feet.heightOnFeetsAndInches ?? ""
    }
    
    func offsetToInches(_ offset: CGFloat)->Int{
        let startHeight = 58
        let progress = offset / HeightTick.spacing
        let heightInches = startHeight + Int(progress)
        return heightInches
    }
    
    func inchesToOffset(_ inches: Int) -> CGFloat {
        let i = inches - 58
        let b = CGFloat(i) / HeightTick.spacing
        return b
        
    }
}

struct HeightTicks: View {
    let picker = 5 // times 5
    @Binding var offset: CGFloat

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            HeightSlider(pickerCount: picker, offset: $offset) {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(1...picker, id: \.self) { index in
                        HeightTick()
                        ForEach(1...4, id: \.self) { subIndex in
                            HeightTick(subIndex: subIndex)
                        }
                    }
                    HeightTick()
                }
            }
            .frame(width: HeightTick.width)
            .padding(.trailing, 90)

        } // HSTACK
    }
    

}
struct HeightTick: View {
    static let width: CGFloat = 100
    static let spacing: CGFloat = 50
    
    let index: Int = 1
    var subIndex: Int = 0
    
    var body: some View {
        Rectangle()
            .fill(Color.DarkBlue)
            .frame(width: large() ? HeightTick.width:50, height: 1)
            .frame(height: HeightTick.spacing)
    }
    
    func large()->Bool{
        return subIndex < 1
    }
}

struct HeightSlider<Content: View> : UIViewRepresentable {
    
    var content: Content
    
    @Binding var offset: CGFloat
    var pickerCount: Int
    
    init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()->Content){
        self.content = content()
        self._offset = offset
        self.pickerCount = pickerCount
    }
    
    func makeCoordinator() -> Coordinator {
        return HeightSlider.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let swiftUIView = UIHostingController(rootView: content).view!
        
        let dunno: CGFloat = 146
        let padding: CGFloat = 130
        let heightOffset = padding + HeightTick.spacing + dunno
        let height = CGFloat((pickerCount * 5) * Int(HeightTick.spacing)) + (getRect().height - heightOffset) // 326

        swiftUIView.frame = CGRect(x: 0, y: 0, width: HeightTick.width, height: height)
        
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = context.coordinator
        scrollView.backgroundColor = UIColor(.clear)
        swiftUIView.backgroundColor = .clear
        
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
    
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: HeightSlider
        
        init(parent: HeightSlider){
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.y
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            
            let value = (offset / HeightTick.spacing).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: 0, y: value * HeightTick.spacing), animated: false)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                let offset = scrollView.contentOffset.y
                
                let value = (offset / HeightTick.spacing).rounded(.toNearestOrAwayFromZero)
                
                scrollView.setContentOffset(CGPoint(x: 0, y: value * HeightTick.spacing), animated: false)
            }
        }
    }
}


#if DEBUG
struct HeightView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.height)
    }
}
#endif

public struct LengthFormatters {

    public static let imperialLengthFormatter: LengthFormatter = {
        let formatter = LengthFormatter()
        formatter.isForPersonHeightUse = true
        formatter.unitStyle = .short
        return formatter
    }()

}

extension Measurement where UnitType : UnitLength {

    var heightOnFeetsAndInches: String? {
        guard let measurement = self as? Measurement<UnitLength> else {
            return nil
        }
        let meters = measurement.converted(to: .meters).value
        return LengthFormatters.imperialLengthFormatter.string(fromMeters: meters)
    }

}
