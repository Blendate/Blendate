//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct MembershipView: View {
    @EnvironmentObject var purchaseManager: StoreManager
    @Environment(\.dismiss) private var dismiss
        
    let TapSubscribe = "By tapping Subscribe, your payment will be charged to your Apple App Store account, and your subscription will automatically renew for the same package length at the same price until you cancel in settings in the Apple App Store. By tapping Subscribe you agree to our Terms"
    
    var body: some View {
        VStack {
            Text(TapSubscribe)
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
                    AsyncButton("Restore"){
                        await purchaseManager.restore()
                    }
                }
                .foregroundColor(.Blue)
                .font(.callout.weight(.semibold))
                .padding()
                PerksTabView()
                List(purchaseManager.products.sorted(by: {$0.price < $1.price})) { product in
                    if !product.isLike {
                        Cell(product: product)
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
    }
}
import StoreKit
extension MembershipView {
    
    struct Cell: View {
        @EnvironmentObject var purchase: StoreManager
        @State var error: ErrorAlert?
        let product: Product
        
        var body: some View {
            AsyncButton(action: purchase) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(product.displayName)
//                            if product.membership == .yearly {
//                                Text("Most Popular")
//                                    .font(.caption2)
//                                    .padding(.horizontal, 8)
//                                    .padding(.vertical, 6)
//                                    .background(Color.Blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(16)
//                            }
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(product.displayPrice)")
                                .bold()
                        }
                        .font(.caption)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }

            }
            .errorAlert(error: $error) { error in
//                AsyncButton("Try Again", action: purchase)
                Button("Ok"){}
            }
        }
        
        private func purchase() async {
            self.error = ComingSoon()

//            do {
//                try await purchase.purchase(product)
//            } catch {
//                self.error = PurchaseManager.Error()
//            }

        }
    }
    
    struct ComingSoon: ErrorAlert {
        var title: String = "Premium"
        
        var message: String = "Premium Membership will be active soon"
        
        
    }

    
    struct PerksTabView: View {
        let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        @State private var selection: PremiumPerks = .matches
        var body: some View {
            TabView(selection: $selection) {
                ForEach(PremiumPerks.allCases) { perk in
                    VStack {
                        Image(perk.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
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
            .environmentObject(StoreManager())
//            .environmentObject(SettingsViewModel(alice.id!))
//            .preferredColorScheme(.dark)
    }
}


