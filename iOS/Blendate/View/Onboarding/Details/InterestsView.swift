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
    var isFilter: Bool = false
    let isSignup: Bool
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    @State private var presentAlert = false
    @State private var error: AlertError?
        
    var body: some View {
        VStack(spacing: 0) {
            SignupTitle(.interests, isFilter)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Interest.allCases, id: \.self) { item in
                        cell(item)
//                        ItemArray($interests, item)
                    }
                }
            }
            if isSignup {
                Button("Start Blending", action: startTapped)
                .fontType(.semibold, 22, .Blue)
                .tint(.white)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .padding(.bottom)
            }
        }
        .padding(.horizontal)

            .errorAlert(error: $error, retry: startTapped)

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
    
    private func startTapped(){
        self.error = handleAlert(session.createUserDoc)
//        do {
//            try session.createUserDoc()
//        } catch {
//            self.error = error as? AlertError
//        }
    }
    
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.interests)
    }
}


@MainActor
func handleAlert(_ action: @MainActor() throws -> Void) -> AlertError? {
    do {
        try action()
        return nil
    } catch let error as AlertError {
        return error
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
