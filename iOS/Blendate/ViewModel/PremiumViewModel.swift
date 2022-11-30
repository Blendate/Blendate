//
//  PremiumViewModel.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI
import RevenueCat

enum SubsciptionState { case unknown, subscribed, notSubscribed }
enum OfferingsState { case unknown, fetched, noOfferings }

class PremiumViewModel: ObservableObject {
    @Published var subsciptionState: SubsciptionState = .unknown
    @Published var offeringsState: OfferingsState = .unknown
    @Published var packages: [Package] = []
    
    
    @Published var showMembership = false
    @Published var showSuperLike = false
    
    @Published var settings: Settings

    private let uid: String
    
    var hasPremium: Bool { subsciptionState == .subscribed }
    
    private let settingsService: FirebaseService = FirebaseService<Settings>(collection: "settings")

    init(_ uid: String){
        self.uid = uid
        self.settings = Settings(id: uid)
    }
    
    func getOfferings() throws {
        Task { @MainActor in
            let offerings = try await RevenueCatService.getOfferings()
            if let packages = offerings?.current?.availablePackages {
                offeringsState = .fetched
                self.packages = packages
            } else {
                offeringsState = .noOfferings
            }
        }
    }
    
    @MainActor
    func login(uid: String) async {
        do {
            self.settings = try await settingsService.fetch(fid: uid)
            let (customerInfo, _) = try await RevenueCatService.logIn(uid)
            try await isActive(Secrets.entitlement, customerInfo: customerInfo)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func isActive(_ entitlementId: String, customerInfo: CustomerInfo?) async throws {
        let isActive = try await RevenueCatService.isActive(entitlementId, customerInfo: customerInfo)
        if let isActive = isActive {
            subsciptionState = isActive ? .subscribed : .notSubscribed
        } else {
            subsciptionState = .notSubscribed
        }
    }
    
    @MainActor
    func purchase(_ package: Package) async throws {
        let (_, customerInfo, _) = try await RevenueCatService.purchase(package: package)
        if package.isLike {
            let likeString = package.storeProduct.productIdentifier.filter { "0"..."9" ~= $0 }
            if let likes = Int(likeString) {
                settings.superLikes += likes
                try saveSettings()
            }
        } else {
            try await isActive(Secrets.entitlement, customerInfo: customerInfo)
        }
    }
    
    func restore() async {
        do {
            try await RevenueCatService.restorePurchases()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func saveSettings() throws {
        try settingsService.update(settings)
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
                    try settingsService.update(settings)
                }
            case .authorized:
                if let fcm = fcm, settings.notifications.fcm != fcm {
                    settings.notifications = Notifications(fcm: fcm, isOn: true)
                    try settingsService.update(settings)
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
