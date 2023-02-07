//
//  PremiumViewModel.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI
import RevenueCat

class SettingsViewModel: FirestoreService<User.Settings> {

    @Published var hasPremium: Bool = false
    @Published var packages: [RevenueCat.Package] = []
    
    var likePackages: [Package] { packages.filter{$0.isLike} }
    var membershipPackages: [Package] { packages.filter{!$0.isLike} }
    
    @Published var showMembership = false
    @Published var showSuperLike = false
    
    @Published var settings: User.Settings

    private let uid: String
    

    init(_ uid: String){
        self.uid = uid
        self.settings = User.Settings(id: uid)
        super.init(collection: Self.Settings)
    }
    
    @MainActor
    func fetchSettings() async {
        if let settings = try? await fetch(fid: uid) {
            self.settings = settings
        }
    }
    
    func useSuperLike(){
        settings.superLikes -= 1
        saveSettings()
    }
    
    func saveSettings() {
        try? update(settings)
    }
}

extension SettingsViewModel {
    
    @MainActor
    func fetchOfferings() async {
        let offerings = try? await RevenueCatService.getOfferings()
        if let packages = offerings?.current?.availablePackages {
            self.packages = packages
        }
    }
    
    func login(uid: String) async {
        do {
            await fetchSettings()
            let (customerInfo, _) = try await RevenueCatService.logIn(uid)
            await setMembership(customerInfo)
        } catch {
            print("RevenueCat Login", error)
        }
    }
    
    
    @MainActor
    func setMembership(_ customerInfo: CustomerInfo?) async {
        let isActive = try? await RevenueCatService.isActive(Secrets.entitlement, customerInfo: customerInfo)
        self.hasPremium = isActive ?? false
    }
    
    @MainActor
    func purchase<P:Package>(_ package: P) async throws {
        guard let package = package as? RevenueCat.Package else {return}
        let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
        if package.isLike {
            let likeString = package.storeProduct.productIdentifier.filter { "0"..."9" ~= $0 }
            if let likes = Int(likeString) {
                settings.superLikes += likes
                saveSettings()
            }
        } else {
            await setMembership(customerInfo)
        }
    }
    
    func restore() async {
        do {
            try await RevenueCatService.restorePurchases()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SettingsViewModel {
    @MainActor
    func checkNotification() async {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus: UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            
            let fcm = UserDefaults.standard.string(forKey: String.kFCMstring)
            
            switch authStatus {
            case .notDetermined:
                let approved = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
                if let fcm = fcm, approved {
                    settings.notifications = User.Settings.Notifications(fcm: fcm, isOn: true)
                    try update(settings)
                }
            case .authorized:
                if let fcm = fcm, settings.notifications.fcm != fcm {
                    settings.notifications = User.Settings.Notifications(fcm: fcm, isOn: true)
                    try update(settings)
                }
            default:
                break
            }
        } catch {
            print("🔔 [Notification] Error", error)
        }
    }
}

// MARK: Package
protocol Package {
    var title: String {get}
    var isLike: Bool {get}
    var membership: Membership? {get}
    var price: String {get}

}
enum Membership: String { case monthly, semiAnnual, yearly, lifetime}
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
