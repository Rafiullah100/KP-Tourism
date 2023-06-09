//
//  AppDelegate.swift
//  Tourism app
//
//  Created by Rafi on 10/10/2022.
//

import UIKit
//import GoogleMaps
import IQKeyboardManager
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseCore
import GoogleSignIn
import Firebase
import FirebaseCrashlytics
@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        window = UIWindow(frame: UIScreen.main.bounds)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.reloadTabbar), object: nil)
//        if UserDefaults.standard.theme == ThemeMode.dark.rawValue {
//            if #available(iOS 13.0, *){
//                window?.overrideUserInterfaceStyle = .dark
//            }
//        }
//        else{
//            if #available(iOS 13.0, *){
//                window?.overrideUserInterfaceStyle = .light
//            }
//        }
        
        UserDefaults.standard.loadFirstTime = true

//        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Light", size: 10) ?? UIFont()], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Light", size: 10) ?? UIFont()], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "tabbarTextColor") ?? UIColor()], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "tabbarTextColor") ?? UIColor()], for: .selected)
//        setupGoogleMap()
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
//        if #available(iOS 13, *){
//            window?.overrideUserInterfaceStyle = .unspecified
//        }

        return true
    }
    
//    func setupGoogleMap(){
//        GMSPlacesClient.provideAPIKey(Constants.googleMapApiKey)
//        GMSServices.provideAPIKey(Constants.googleMapApiKey)
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

