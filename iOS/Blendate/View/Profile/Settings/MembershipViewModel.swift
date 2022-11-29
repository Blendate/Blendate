//
//  MembershipViewModel.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import Foundation
import RevenueCat

class MembershipViewModel: ObservableObject {
    
    @Published var packages: [Package] = []

    @MainActor
    func getPackages() {
        Purchases.shared.getOfferings { offering, error in
            self.packages = offering?.current?.availablePackages ?? []
        }
    }
    
    func purchase(_ package: Package) {
        Task {
            do {
                let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
                if let customerInfo = customerInfo {
                    print(customerInfo)
                }
            } catch {
                print(error.localizedDescription)
            }
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

