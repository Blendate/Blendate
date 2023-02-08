//
//  RevenueCatService.swift
//  RevenueCatFirebaseExample
//
//  Created by Alex Nagy on 23.07.2022.
//

import RevenueCat

struct RevenueCatService {
    
    @discardableResult
    static func configure(withAPIKey apiKey: String) -> Purchases {
        let configuration = Configuration.Builder(withAPIKey: apiKey)
            .with(usesStoreKit2IfAvailable: true)
            .build()
        return Purchases.configure(with: configuration)
    }
    
    static func setFirebaseAppInstanceId(_ id: String?) {
        if let id {
//            print("Instance ID -> " + unwrapped);
//            print("Setting Attributes");
            Purchases.shared.attribution.setAttributes(["$firebaseAppInstanceId": id])
        } else {
            print("Instance ID -> NOT FOUND!");
        }
    }
    
    @discardableResult
    static func logIn(_ uid: String) async throws -> (CustomerInfo?, Bool) {
        try await withCheckedThrowingContinuation({ continuation in
            Purchases.shared.logIn(uid, completion: { (customerInfo, created, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: (customerInfo, created))
            })
        })
    }
    
    @discardableResult
    static func getCustomerInfo() async throws -> CustomerInfo? {
        try await withCheckedThrowingContinuation({ continuation in
            Purchases.shared.getCustomerInfo { (customerInfo, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: customerInfo)
            }
        })
    }
    
    @discardableResult
    static func getOfferings() async throws -> Offerings? {
        try await withCheckedThrowingContinuation({ continuation in
            Purchases.shared.getOfferings { (offerings, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: offerings)
            }
        })
    }
    
    @discardableResult
    static func restorePurchases() async throws -> CustomerInfo? {
        try await withCheckedThrowingContinuation({ continuation in
            Purchases.shared.restorePurchases { customerInfo, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: customerInfo)
            }
        })
    }
    
    @discardableResult
    static func purchase(package: RevenueCat.Package) async throws -> (StoreTransaction?, CustomerInfo?, Bool) {
        try await withCheckedThrowingContinuation({ continuation in
            Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: (transaction, customerInfo, userCancelled))
            }
        })
    }
    
    static func isActive(_ entitlementId: String, customerInfo: CustomerInfo?) async throws -> Bool? {
        customerInfo?.entitlements[entitlementId]?.isActive
    }
}

extension RevenueCat.Package: Package {
    var title: String {
        switch storeProduct.productIdentifier {
        case String.Yearly_ID:
            return String(12) + " Month"
        case String.SemiAnnual_ID:
            return String(6) + " Month"
        case String.Monthly_ID:
            return String(1) + " Month"
        case String.Lifetime_ID:
            return "Lifetime"
        default: return ""
        }
    }
    
    var isLike: Bool {
        storeProduct.productIdentifier.contains("like")
    }
    
    var membership: Membership? {
        switch storeProduct.productIdentifier {
        case String.Yearly_ID:
            return .yearly
        case String.SemiAnnual_ID:
            return .semiAnnual
        case String.Monthly_ID:
            return .monthly
        case String.Lifetime_ID:
            return .lifetime
        default: return nil
        }
    }
    
    var price: String {
        storeProduct.localizedPriceString
    }

}
