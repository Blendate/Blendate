//
//  PurchaseLikesView.swift
//  Blendate
//
//  Created by Michael on 11/30/22.
//

import SwiftUI
import RevenueCat

struct PurchaseLikesView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var model: PremiumViewModel
    var packages: [Package] { model.packages.filter{$0.isLike} }

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
            await model.fetchOfferings()
        }
    }
    
    var packageButtons: some View {
        VStack {
            ForEach(packages) { package in
                AsyncButton {
                    try? await model.purchase(package)
                } label: {
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Text(package.storeProduct.localizedTitle)
                                    .foregroundColor(.primary)
                                Text(package.storeProduct.localizedPriceString)
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
