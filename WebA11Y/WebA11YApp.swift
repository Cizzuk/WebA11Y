//
//  WebA11YApp.swift
//  WebA11Y
//
//  Created by Cizzuk on 2023/01/05.
//

import SwiftUI
import UIKit

// MARK: - Global Constants

let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!

// MARK: - App Entry Point
@main
struct WebA11YApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

// MARK: - App Delegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let lastVersion: String = userDefaults.string(forKey: "LastAppVer") ?? ""
        
        if lastVersion.isEmpty {
            // Get current device accessibility settings
            
            // Bold Text
            let isBoldTextEnabled = UIAccessibility.isBoldTextEnabled
            userDefaults.set(isBoldTextEnabled, forKey: "boldText")
            
            // Button Shapes (iOS 26+: Show Borders)
            let isButtonShapesEnabled = UIAccessibility.buttonShapesEnabled
            userDefaults.set(isButtonShapesEnabled, forKey: "buttonShape")
        }
        
        // Save last opened version
        userDefaults.set(currentVersion, forKey: "LastAppVer")
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
