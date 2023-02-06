//
//  PremiumViewModel.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI
import RevenueCat


class PremiumViewModel: FirebaseService<Settings> {

    @Published var hasPremium: Bool = false
    @Published var packages: [Package] = []
    
    
    @Published var showMembership = false
    @Published var showSuperLike = false
    
    @Published var settings: Settings

    private let uid: String
    

    init(_ uid: String){
        self.uid = uid
        self.settings = Settings(id: uid)
        super.init(collection: "settings")
    }
    
    func fetchSettings() async {
        if let settings = try? await fetch(fid: uid) {
            self.settings = settings
        }
    }
    
    func saveSettings() {
        try? update(settings)
    }
}

extension PremiumViewModel {
    
    @MainActor
    func fetchOfferings() async {
        let offerings = try? await RevenueCatService.getOfferings()
        if let packages = offerings?.current?.availablePackages {
            self.packages = packages
        }
    }
    
    @MainActor
    func login(uid: String) async {
        do {
            await fetchSettings()
            let (customerInfo, _) = try await RevenueCatService.logIn(uid)
            await isActive(customerInfo)
        } catch {
            print(error)
        }
    }
    
    
    @MainActor
    private func isActive(_ customerInfo: CustomerInfo?) async {
        let isActive = try? await RevenueCatService.isActive(Secrets.entitlement, customerInfo: customerInfo)
        self.hasPremium = isActive ?? false
    }
    
    @MainActor
    func purchase(_ package: Package) async throws {
        let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
        if package.isLike {
            let likeString = package.storeProduct.productIdentifier.filter { "0"..."9" ~= $0 }
            if let likes = Int(likeString) {
                settings.superLikes += likes
                saveSettings()
            }
        } else {
            await isActive(customerInfo)
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

extension PremiumViewModel {
    func checkNotification() async {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus: UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            
            let fcm = UserDefaults.standard.string(forKey: String.kFCMstring)
            
            switch authStatus {
            case .notDetermined:
                let approved = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
                if let fcm = fcm, approved {
                    settings.notifications = Notifications(fcm: fcm, isOn: true)
                    try update(settings)
                }
            case .authorized:
                if let fcm = fcm, settings.notifications.fcm != fcm {
                    settings.notifications = Notifications(fcm: fcm, isOn: true)
                    try update(settings)
                }
            default:
                break
            }
        } catch {
            print("🔔 [Notification] Error")
            print(error)
        }
    }
}

extension Package {
    var isLike: Bool {
        storeProduct.productIdentifier.contains("like")
    }
}
