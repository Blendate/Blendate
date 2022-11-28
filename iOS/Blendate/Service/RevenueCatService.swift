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
        if let unwrapped = id {
            print("Instance ID -> " + unwrapped);
            print("Setting Attributes");
            Purchases.shared.attribution.setAttributes(["$firebaseAppInstanceId": unwrapped])
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
    static func purchase(package: Package) async throws -> (StoreTransaction?, CustomerInfo?, Bool) {
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

