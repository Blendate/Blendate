//
//  SignupViewMod.swift
//  Blendate
//
//  Created by Michael on 4/8/22.
//

import SwiftUI

enum Position {
    case top
    case bottom
    case center
}

struct SignupViewMod: View {
    @Binding var details: Details
    let type: Detail
    
    init(_ details: Binding<Details>, _ type: Detail){
        self._details = details
        self.type = type
    }
    
    var body: some View {
        Group {
            if position == .center {
                center
            } else {
                vertical
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SignupViewMod($details, next)
                } label: {
                    nextLabel
                }.disabled((!valueValid && type.required) || type == .interests)
            }
        }
    }


    var center: some View {
        VStack(spacing: 0) {
            if imagePosition == .bottom {
                VStack(spacing: 0) {
                    SignupTitle(type, imagePosition)
                    Spacer()
                    getDestination()
                }
            }
            imageBubble
            if imagePosition == .top {
                VStack(spacing: 0) {
                    SignupTitle(type, imagePosition)
                    getDestination()
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(imagePosition == .top ? .top:.bottom)

    }
    
    var vertical: some View {
        ZStack {
            VStack(spacing: 0) {
                if imagePosition == .bottom {
                    Spacer()
                }
                imageBubble
                if imagePosition == .top {
                    Spacer()
                }
            }.edgesIgnoringSafeArea(imagePosition == .top ? .top:.bottom)

            VStack(spacing: 0) {
                if position == .bottom {
                    Spacer()
                }
                SignupTitle(type, imagePosition)
                getDestination()
                if position == .top {
                    Spacer()
                }
            }
        }
    }


}


struct SignupViewMod_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.name)
        PreviewSignup(.birthday)
        PreviewSignup(.gender)

    }
}

