////
////  SigninOptions.swift
////  Blendate
////
////  Created by Michael on 1/17/22.
////
//
//import SwiftUI
//import FirebaseEmailAuthUI
//import FirebaseOAuthUI
//import FirebaseGoogleAuthUI
//import FirebaseFacebookAuthUI
//
//class MyAuthViewController : FUIAuthPickerViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//
//        for each in view.subviews[0].subviews[0].subviews[0].subviews {
//            if let button = each as? UIButton {
//                button.layer.cornerRadius = 20.0
//                button.layer.masksToBounds = true
////                button.layer.backgroundColor = UIColor.white.cgColor
////                button.setTitleColor(UIColor.black, for: .normal)
//            }
//        }
//        
//        let scrollView = view.subviews[0] as! UIScrollView
//        scrollView.isScrollEnabled = false
//        scrollView.backgroundColor = .clear
//        let contentView = scrollView.subviews[0]
//        contentView.backgroundColor = .clear
////        let background = UIImage(named: "imagename")
////        let backgroundImageView = UIImageView(image: background)
////        backgroundImageView.contentMode = .scaleToFill
////        view.insertSubview(backgroundImageView, at: 0)
//    }
//    
//    
//}
//
//class AuthManager : NSObject{
//       
//    static let shared = AuthManager()
//
//    var authViewController : UIViewController {
//        return MyAuthViewController(authUI: FUIAuth.defaultAuthUI()!)
//    }
//    
//    var actionCodeSettings: ActionCodeSettings {
//        let actionCodeSettings = ActionCodeSettings()
//        actionCodeSettings.url = URL(string: "https://blendate.page.link/email")
//        actionCodeSettings.handleCodeInApp = true
//        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
//        return actionCodeSettings
//    }
//    override init(){
//        super.init()
//        guard let authUI = FUIAuth.defaultAuthUI() else {return}
//            let providers: [FUIAuthProvider] = [
////                FUIEmailAuth(authAuthUI: authUI, signInMethod: EmailLinkAuthSignInMethod, forceSameDevice: false, allowNewEmailAccounts: true, actionCodeSetting: actionCodeSettings),
////                FUIEmailAuth(),
//                FUIOAuth.appleAuthProvider(),
//                FUIGoogleAuth(authUI: authUI),
//                FUIFacebookAuth(authUI: authUI, permissions: ["email", "public_profile"]),
////                FUIFacebookAuth(authUI: authUI),
//
////                FUIOAuth.twitterAuthProvider(withAuthUI: authUI),
//            ]
//        authUI.providers = providers
//    }
//    
//    
////    func setAuthDelegate(_ delegate : FUIAuthDelegate){
////        FUIAuth.defaultAuthUI()?.delegate = delegate
////    }
//}
//
//
//
//struct SocialSigninButtons: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<SocialSigninButtons>) ->
//        UIViewController {
//        return AuthManager.shared.authViewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController,
//               context: UIViewControllerRepresentableContext<SocialSigninButtons>) {
//    }
//}
