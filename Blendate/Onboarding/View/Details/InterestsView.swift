//
//  InterestsView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI

struct InterestsView: View {
    @EnvironmentObject var session: SessionViewModel
    
    @Binding var interests:[String]
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    @State private var presentAlert = false
    @State private var error: AlertError?
        
    var body: some View {
        VStack(spacing: 0) {
            SignupTitle(.interests)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Interest.allCases, id: \.self) { item in
                        cell(item)
//                        ItemArray($interests, item)
                    }
                }
            }
            Button("Start Blending", action: startTapped)
            .fontType(.semibold, 22, .Blue)
            .tint(.white)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding(.bottom)
        }
        .padding(.horizontal)

            .errorAlert(error: $error, retry: startTapped)

    }
    
    private func startTapped(){
        do {
            try session.creasteUserDoc()
        }catch let error as AlertError {
           self.error = error
        } catch {
            self.error = AlertError(errorDescription: "Server Error", failureReason: "There was an error creating your account", recoverySuggestion: "Try again", helpAnchor: error.localizedDescription)
        }
    }
    
    
    @ViewBuilder
    func cell(_ interest: Interest) -> some View {
        let active = interests.contains(interest.value)
        
        Button {
            interests.tapItem(interest.value)
        } label: {
            VStack{
                Text(interest.title)
                    .fontType(.semibold, 16, active ? .white:.DarkBlue)
                Text(interest.subString)
                    .fontType(.regular, 12, active ? .LightGray:.gray)
                
            }
            .padding()
            .background(active ? Color.Blue:Color.white)
            .cornerRadius(18)
            .shadow(color: .Blue, radius: 1, x: 0, y: 1)
        }
    }
    
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.interests)
    }
}
