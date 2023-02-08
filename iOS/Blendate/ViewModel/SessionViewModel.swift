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
    
    @Published var user = User()
    @Published var settings = User.Settings()
    
    @Published var showMembership = false
    @Published var showSuperLike = false
    @Published var hasPremium: Bool = false
    
    @Published var packages: [RevenueCat.Package] = []
    
    let uid: String
    
    init(_ uid: String){
        self.uid = uid
        super.init()
        print("Init \(uid)")
    }
    
    #warning("better check than just firstname")
    #warning("Properly fertch settings")
    @MainActor
    func fetchFirebase() async {
        do {
            self.user = try await fetch(fid: uid)
            self.settings = try await FirestoreService<User.Settings>().fetch(fid: uid)
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
        let _ = try create(user, fid: uid)
        let settingsService = FirestoreService<User.Settings>()
        let _ = try settingsService.create(User.Settings(), fid: uid )
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
    
    func login() async {
        do {
            let (customerInfo, _) = try await RevenueCatService.logIn(uid)
            await setMembership(customerInfo)
            await fetchOfferings()
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
protocol Package {
    var title: String {get}
    var isLike: Bool {get}
    var membership: Membership? {get}
    var price: String {get}
}
enum Membership: String { case monthly, semiAnnual, yearly, lifetime}


// MARK: - Notifications
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


