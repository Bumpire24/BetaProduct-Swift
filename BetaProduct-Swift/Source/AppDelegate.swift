//
//  AppDelegate.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDependencies = AppDependencies()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BetaProductTheme.current.apply()
        appDependencies.installRootViewController(InWindow: window!)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appDependencies.showLoginViewAndClearSession(InWindow: window!)
    }
}

