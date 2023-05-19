//
//  TravelTimeSchedulerApp.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2023/03/31.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase
import GoogleMobileAds
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      // Firebase
      FirebaseApp.configure()
      // Enable offline cache
      Database.database().isPersistenceEnabled = true
      // Google AdMob
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      
    return true
  }
    
    // 追加 
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct TravelTimeSchedulerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                    TopMainTravelView()
            }
        }
    }
}
