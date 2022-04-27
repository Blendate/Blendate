//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var session: SessionViewModel
    @Binding var user: User

    var body: some View {
        NavigationView {
            SignupViewMod($user.details, .name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { try? FirebaseManager.instance.auth.signOut() }) {
                            Image(systemName: "chevron.left")
                                .tint(.Blue)
                        }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SignupTitle: View {
    let detail: Detail
    let imagePosition: Position
    
    init(_ detail: Detail, _ position: Position){
        self.detail = detail
        self.imagePosition = position
    }
    
    var body: some View {
        Text(detail.title)
            .fontType(.semibold, 32, .DarkBlue)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            .padding(.horizontal)
    }
}

struct ItemButton<T:Property>: View {
    
    @Binding var value: String
    var property: T

    init(_ value: Binding<String>, _ property: T){
        self._value = value
        self.property = property
    }
    
    
    var body: some View {
        let active = active()
        Button {
            value = property.value
        } label: {
            Text(property.value)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.Blue, lineWidth: 2)
                )
        }

    }
    
    func active()->Bool{
        if let property = property.id as? String{
            return property == value
        } else {
            return false
        }
    }
}



struct ItemArray<T:Property>: View {
    @Binding var array: [String]
    var property: T
    
    init(_ array: Binding<[String]>, _ property: T){
        self._array = array
        self.property = property
    }
    
    var body: some View {
        let active = array.contains(property.value)
        Button(action: {
            array.tapItem(property.value)
        }) {
            Text(property.value)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.Blue, lineWidth: 2)
                )
        }
    }
}

extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace }) || isEmpty
  }
}

