//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct MembershipView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    //    @Binding var premium: Premium
    
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
                    AsyncButton("Restore") {
                        await settings.restore()
                    }
                }
                .foregroundColor(.Blue)
                .font(.callout.weight(.semibold))
                .padding()
                PerksTabView()
                List(settings.packages) { package in
                    if !package.isLike {
                        Cell(package: package)
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
        .task {
//            await model.fetchOfferings()
        }
        
    }
}
extension MembershipView {
    
    struct Cell<P:Package>: View {
        @EnvironmentObject var settings: SettingsViewModel
        let package: P
        var body: some View {
            AsyncButton {
                try? await settings.purchase(package)
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(package.title)
                            if package.membership == .yearly {
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
                            Text("\(package.price)")
                                .bold()
                        }
                        .font(.caption)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }

            }
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
//            .environmentObject(SettingsViewModel(dev.michael.id!))
//            .preferredColorScheme(.dark)
    }
}


