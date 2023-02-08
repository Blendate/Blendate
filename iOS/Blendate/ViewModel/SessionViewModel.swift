//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI
import RevenueCat

enum SessionState {case noUser, user, loading}

class SessionViewModel: FirestoreService<User> {

    @Published var selectedTab: Tab = .match
    @Published var loadingState: SessionState = .loading
    
    @Published var showMembership = false
    @Published var showSuperLike = false
    
    @Published var hasPremium: Bool = false
    @Published var packages: [RevenueCat.Package] = []
    @Published var user: User
    @Published var settings: User.Settings


    let uid: String
    init(_ uid: String){
        self.uid = uid
        self.user = User(id: uid)
        self.settings = User.Settings(id: uid)
        super.init(collection: Self.Users)
        print("Init \(uid)")
    }
    
    #warning("better check than just firstname")
    #warning("Properly save settings")
    @MainActor
    func fetchFirebase() async {
        do {
            self.user = try await fetch(fid: uid)
//            if let settings = try? await fetch(fid: uid) {
//                self.settings = settings
//            }
            withAnimation(.spring()) {
                self.loadingState = user.firstname.isEmpty ? .noUser : .user
            }
        } catch {
            print(error.localizedDescription)
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }

    @MainActor
    func createUserDoc() throws {
        try create(user)
        
        let settingsService = FirestoreService<User.Settings>(collection: Self.Settings)
        try settingsService.create( User.Settings(id: user.id) )
        loadingState = .user
    }

    func saveUser() throws {
        try update(user)
    }
    
    func saveSettings() {
//        try? update(settings)
    }
    func useSuperLike(){
        settings.superLikes -= 1
        saveSettings()
    }
}


// MARK: - Premium
extension SessionViewModel {
    
    @MainActor
    func fetchOfferings() async {
        let offerings = try? await RevenueCatService.getOfferings()
        if let packages = offerings?.current?.availablePackages {
            self.packages = packages
        }
    }
    
    func login(uid: String) async {
        do {
            #warning("Properly fetch settings")

//            await fetchSettings()
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

extension SessionViewModel {
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
                    saveSettings()
                }
            case .authorized:
                if let fcm = fcm, settings.notifications.fcm != fcm {
                    settings.notifications = User.Settings.Notifications(fcm: fcm, isOn: true)
                    saveSettings()
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
