//
//  PurchaseLikesView.swift
//  Blendate
//
//  Created by Michael on 11/30/22.
//

import SwiftUI

struct PurchaseLikesView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                HStack(alignment: .top) {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(.Blue)
                    }
                }
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.DarkPink)
                    .clipShape(Circle())
            }
            .padding([.top, .trailing])
            Text(Self.Attention)
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(4)
            Text(Self.SuperLike)
                .multilineTextAlignment(.center)
                .font(.footnote)
            packageButtons
            Spacer()
        }
        .padding(.horizontal)
        .task {
            await settings.fetchOfferings()
        }
    }
    
    var packageButtons: some View {
        VStack {
            ForEach(settings.packages) { package in
                AsyncButton {
                    try? await settings.purchase(package)
                } label: {
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Text(package.title)
                                    .foregroundColor(.primary)
                                Text(package.title)
                                    .foregroundColor(.Blue)
                            }.fontWeight(.bold)
                            Text("$1.99 each")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                        Spacer()
                    }
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.Blue, lineWidth: 1)
                    )
                }

            }
        }
        .padding(.horizontal, 32)
    }
}


struct PurchaseLikesView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseLikesView()
    }
}
