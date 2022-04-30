//
//  HelpCenterView.swift
//  Blendate
//
//  Created by Michael on 6/17/21.
//

import SwiftUI

struct HelpCenterView: View {
    var body: some View {
        ZStack {
            background
            VStack {
                Text("Help Center")
                    .fontType(.regular, 28, .white)
                    .padding(.bottom)
                HelpCell()
                HelpCell()
                HelpCell()
                HelpCell()
                HelpCell()
                HelpCell()

                Spacer()
            }

        }
    }
    
    var background: some View {
        VStack {
            Image("Ellipse_Top")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            Spacer()
        }
    }
}

struct HelpCell: View {
    @State var open: Bool = true
    
    var body: some View {
            HStack{
                Text("What is Blendate?")
                    .padding(25)
                Spacer()
                Image("helpIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
            }.clipShape(Capsule())
            .background(Capsule()
                            .fill(Color.white)
                            .shadow(color: .gray, radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4))
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

struct HelpCenterView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterView()
    }
}
