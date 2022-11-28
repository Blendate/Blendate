//
//  MembershipView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI
import RevenueCat

struct MembershipView: View {
    @Binding var premium: Premium
    @State var packages: [Package] = []

    var body: some View {
        VStack {
            Text(premium.active ? "Subscribed":"Subscribe Now")
            Button(premium.active ? "Unsubscribe":"Subscribe"){
                premium.active.toggle()
            }
            List(packages) { package in
                cell(package)
            }
        }
        .task {
            try? await getOfferings()
        }
    }
    
    func cell(_ package: Package) -> some View {
        Button {
            purchase(package)
        } label: {
            VStack(alignment: .leading) {
                Text("\(package.storeProduct.localizedTitle)")
                VStack(alignment: .leading) {
                    Text("\(package.storeProduct.productIdentifier)")
                        .foregroundColor(.gray)
                    Text("\(package.storeProduct.localizedPriceString)")
                        .bold()
                        .foregroundColor(.green)
                }
                .font(.caption)
            }
        }
    }
    
    
    func purchase(_ package: Package) {
        Task {
            let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
//            try await profileService.isActive(Setup.entitlement, customerInfo: customerInfo)
        }
    }
    
    func restore() {
        Task {
            do {
                try await RevenueCatService.restorePurchases()
                try await getOfferings()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getOfferings() async throws {
        let offerings = try await RevenueCatService.getOfferings()
        if let packages = offerings?.current?.availablePackages {
            self.packages = packages
        } else {
            print("NO Packages")
        }
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView(premium: .constant(Premium()))
    }
}
