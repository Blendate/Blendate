////
////  RevenueCatService.swift
////  RevenueCatFirebaseExample
////
////  Created by Alex Nagy on 23.07.2022.
////
//
//import RevenueCat
//import SwiftUI
//
//
//class RevenueCatService: AppPurchaseService {
//    struct Error: Swift.Error { var localizedDescription = "RevenueCat Error" }
//    typealias P = RevenueCat.Package
//    typealias E = Error
//    
//    required init(){}
//
//    static func login(uid: String) async -> Bool {
//        do {
//            let (customerInfo, _) = try await RevenueCatService.logIn(uid)
//            let isActive = try? await RevenueCatService.isActive(Secrets.entitlement, customerInfo: customerInfo)
//            return isActive ?? false
//        } catch {
//            print("RevenueCat Login", error)
//            return false
//        }
//    }
//
//    func restore() async throws -> Bool {
//        let info = try await RevenueCatService.restorePurchases()
//        return await isActive(info)
//    }
//    
//    func purchase(_ package: P) async throws -> (Bool, Int) {
//        let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
//        let premium = await isActive(customerInfo)
//        var purchasedLikes: Int = 0
//        if package.isLike {
//            let likeString = package.storeProduct.productIdentifier.filter { "0"..."9" ~= $0 }
//            if let likes = Int(likeString) {
//                purchasedLikes = likes
//            }
//        }
//        return (premium, purchasedLikes)
//    }
//    
//    func fetchOfferings() async -> [RevenueCat.Package] {
//        let offerings = try? await RevenueCatService.getOfferings()
//        let packages = offerings?.current?.availablePackages
//        return packages ?? []
//    }
//     
//    private func isActive(_ customerInfo: CustomerInfo?) async -> Bool {
//        let isActive = try? await RevenueCatService.isActive(Secrets.entitlement, customerInfo: customerInfo)
//        return isActive ?? false
//    }
//}
//
//extension RevenueCatService {
//    
//    @discardableResult
//    static func configure(withAPIKey apiKey: String) -> Purchases {
//        let configuration = Configuration.Builder(withAPIKey: apiKey)
//            .with(usesStoreKit2IfAvailable: true)
//            .build()
//        return Purchases.configure(with: configuration)
//    }
//    
//    static func setFirebaseAppInstanceId(_ id: String?) {
//        if let id {
////            print("Instance ID -> " + unwrapped);
////            print("Setting Attributes");
//            Purchases.shared.attribution.setAttributes(["$firebaseAppInstanceId": id])
//        } else {
//            print("Instance ID -> NOT FOUND!");
//        }
//    }
//    
//    @discardableResult
//    static func logIn(_ uid: String) async throws -> (CustomerInfo?, Bool) {
//        try await withCheckedThrowingContinuation({ continuation in
//            Purchases.shared.logIn(uid, completion: { (customerInfo, created, error) in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                continuation.resume(returning: (customerInfo, created))
//            })
//        })
//    }
//    
//    @discardableResult
//    static func getCustomerInfo() async throws -> CustomerInfo? {
//        try await withCheckedThrowingContinuation({ continuation in
//            Purchases.shared.getCustomerInfo { (customerInfo, error) in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                continuation.resume(returning: customerInfo)
//            }
//        })
//    }
//    
//    @discardableResult
//    static func getOfferings() async throws -> Offerings? {
//        try await withCheckedThrowingContinuation({ continuation in
//            Purchases.shared.getOfferings { (offerings, error) in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                continuation.resume(returning: offerings)
//            }
//        })
//    }
//    
//    @discardableResult
//    static func restorePurchases() async throws -> CustomerInfo? {
//        try await withCheckedThrowingContinuation({ continuation in
//            Purchases.shared.restorePurchases { customerInfo, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                continuation.resume(returning: customerInfo)
//            }
//        })
//    }
//    
//    @discardableResult
//    static func purchase(package: RevenueCat.Package) async throws -> (StoreTransaction?, CustomerInfo?, Bool) {
//        try await withCheckedThrowingContinuation({ continuation in
//            Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                continuation.resume(returning: (transaction, customerInfo, userCancelled))
//            }
//        })
//    }
//    
//    static func isActive(_ entitlementId: String, customerInfo: CustomerInfo?) async throws -> Bool? {
//        customerInfo?.entitlements[entitlementId]?.isActive
//    }
//}
//
//extension RevenueCat.Package: Package {
//    var title: String {
//        switch storeProduct.productIdentifier {
//        case String.Yearly_ID:
//            return String(12) + " Month"
//        case String.SemiAnnual_ID:
//            return String(6) + " Month"
//        case String.Monthly_ID:
//            return String(1) + " Month"
//        case String.Lifetime_ID:
//            return "Lifetime"
//        default: return storeProduct.localizedTitle
//        }
//    }
//    
//    var isLike: Bool {
//        storeProduct.productIdentifier.contains("like")
//    }
//    
//    var membership: Membership? {
//        switch storeProduct.productIdentifier {
//        case String.Yearly_ID:
//            return .yearly
//        case String.SemiAnnual_ID:
//            return .semiAnnual
//        case String.Monthly_ID:
//            return .monthly
//        case String.Lifetime_ID:
//            return .lifetime
//        default: return nil
//        }
//    }
//    
//    var price: String {
//        storeProduct.localizedPriceString
//    }
//
//}
