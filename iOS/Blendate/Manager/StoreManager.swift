//
//  PremiumState.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/22/23.
//

import SwiftUI
import StoreKit


//class EntitlementManager: ObservableObject {
//    static let userDefaults: UserDefaults = .standard//UserDefaults(suiteName: "group.your.app")!
//    @AppStorage("hasPro", store: userDefaults)
//    var hasPro: Bool = false
//}

@MainActor
class StoreManager: NSObject, ObservableObject {

    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    private var updates: Task<Void, Never>? = nil
//    private let entitlementManager: EntitlementManager
    
    @Published var hasMembership: Bool = false
    
    override init(){
//        self.entitlementManager = entitlementManager
        super.init()
        self.updates = observeTransactionUpdates()
        SKPaymentQueue.default().add(self)
    }
    
    deinit { updates?.cancel() }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                await self.updatePurchasedProducts()
            }
        }
    }
    
    private var productsLoaded = false
    func fetchProducts() async {
        guard !self.productsLoaded else { return }
        do {
            self.products = try await Product.products(for: Self.Product_IDs)
            self.productsLoaded = true
        } catch {
            print(error)
        }

    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
    
        switch result {
        case let .success(.verified(transaction)):
            await transaction.finish()
            await updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            print(error) /// Could be a jailbroken phone
            break
        case .pending, .userCancelled:
            break
        @unknown default:
            break
       }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {continue}
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
        self.hasMembership = !self.purchasedProductIDs.isEmpty
//        self.entitlementManager.hasPro = !self.purchasedProductIDs.isEmpty
    }
    func restore() async {
        do { try await AppStore.sync() }
        catch { print(error) }
    }

}

// MARK: - Listen for App Purchases from App Store
extension StoreManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        Task {
            await updatePurchasedProducts()
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}

extension StoreManager {
    struct Error: ErrorAlert {
        var title: String = "Purchase Error"
        var message: String = "There was an error processing your payment, try again or contact support"
    }
}




extension StoreManager {
    
    static var Product_IDs: [String] {
        [
            Subscriptions.Yearly,
            Subscriptions.Monthly,
            Subscriptions.SemiAnnual,
            Consumbale.Lifetime,
            Consumbale.Likes3,
            Consumbale.Likes10,
            Consumbale.Likes25
        ]
    }
    
    struct Subscriptions {
        static let Yearly = "com.blendate.blendate.yearly"
        static let Monthly = "com.blendate.blendate.monthly"
        static let SemiAnnual = "com.blendate.blendate.semiAnnual"
    }
    
    struct Consumbale {
        static let Lifetime = "com.blendate.blendate.lifeMembership"
        static let Likes3 = "com.blendate.blendate.likes3"
        static let Likes10 = "com.blendate.blendate.likes10"
        static let Likes25 = "com.blendate.blendate.likes25"
    }

}
