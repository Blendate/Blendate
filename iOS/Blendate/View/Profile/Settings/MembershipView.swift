//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI
import RevenueCat

struct MembershipView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var model: PremiumViewModel
//    @Binding var premium: Premium
    
    var packages: [Package] { model.packages.filter{!$0.isLike} }
    
    var body: some View {
        VStack {
            Text(Self.TapSubscribe)
                .foregroundColor(.white)
                .font(.caption2)
                .padding(.bottom, 8)
            VStack {
//                Text(premium.active ? "Subscribed":"Subscribe Now")
//                Button(premium.active ? "Unsubscribe":"Subscribe"){
//                    premium.active.toggle()
//                }
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                    Spacer()
                    Button("Restore") {
                        model.restore()
                    }
                }
                .foregroundColor(.Blue)
                .font(.callout.weight(.semibold))
                .padding()
                PerksTabView()
                List(packages) { package in
                    if !package.storeProduct.productIdentifier.contains("like") {
                        cell(package)
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
            }
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding()
        .background(Color.Blue)
        .onAppear {
            try? model.getOfferings()
        }
    }
    
    func cell(_ package: Package) -> some View {
        Button {
            model.purchase(package)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(months(for:package)) Month")
                        if package.storeProduct.productIdentifier == Self.Yearly_ID {
                            Text("Most Popular")
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.Blue)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("\(package.storeProduct.localizedPriceString)")
                            .bold()
//                            .foregroundColor(.green)
                    }
                    .font(.caption)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }

        }
    }
    

    
    
    func months(for package: Package) -> Int {
        switch package.storeProduct.productIdentifier {
        case Self.Yearly_ID:
            return 12
        case Self.SemiAnnual_ID:
            return 6
        case Self.Monthly_ID:
            return 1
        default: return 1
        }
    }
    
    struct PerksTabView: View {
        let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        @State private var selection: PremiumPerks = .matches
        var body: some View {
            TabView(selection: $selection) {
                ForEach(PremiumPerks.allCases) { perk in
                    VStack {
                        ZStack {
                            Rectangle().fill(Color.Blue)
                            Text("Placeholder")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .frame(width: 175, height: 175)
                        VStack(alignment: .leading) {
                            Text(perk.title)
                                .font(.title3).fontWeight(.semibold)
                            Text(perk.description)
                                .font(.callout)
                        }
                    }
                    .tag(perk)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .onReceive(timer) { _ in
                withAnimation {
                    selection = selection.next()
                }
            }
        }
    }
    

}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
//            .preferredColorScheme(.dark)
    }
}


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
            Text("Stand out and get their attention with a Super Like")
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(4)
            Text("Super Likes put you at the top of their list and gives you a better chance at matching")
                .multilineTextAlignment(.center)
                .font(.footnote)
            packageButtons
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            try? model.getOfferings()
        }
    }
    
    var packageButtons: some View {
        VStack {
            ForEach(packages) { package in
                Button {
                    model.purchase(package)
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
